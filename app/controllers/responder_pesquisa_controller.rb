# encoding: utf-8
class ResponderPesquisaController < ApplicationController
  def responder_pesquisa
    if usuario_signed_in?
      redirect_to :action => 'index', :controller => 'resultados'
    else
      if params[:id]
        @pesquisa = Pesquisa.find(params[:id])
        unless @pesquisa
          flash[:erro] = "Não foi encontrada uma pesquisa com o identificador indicado"
          redirect_to :action => "responder_pesquisa"
        end
      else
        @pesquisa = Pesquisa.ativa.first
      end
    end
  end
  
  def iniciar_respostas
    return if !valida_respostas?(params)
    
    if @pesquisa.tipo_resposta == PesquisaDocente::TipoResposta::UMA_RESPOSTA_POR_ALUNO
      unless @aluno.ja_respondeu_alguma?(@pesquisa)
        render :iniciar_respostas_unicas
      else
        flash[:sucesso] = 'Você concluiu a sua pesquisa com sucesso !'
        render :action => 'responder_pesquisa', :id => @pesquisa.id
      end
    else
      turmas_falta_responder = @aluno.turmas_falta_responder(@pesquisa)
      
      @atual = @aluno.turmas_respondeu(@pesquisa).length + 1
      @total = @aluno.turmas.count
      @progresso = @aluno.porcentagem_respostas(@pesquisa)
    
      # Caso ainda existam turmas, será escolhida a primeira para o aluno responder
      unless turmas_falta_responder.empty?
        @turma = turmas_falta_responder[0]
      else # Caso contrário, a pesquisa está concluída
        # Verifica se ja respondeu a dimensão coordenador
        @dimensao_coordenador = @pesquisa.dimensoes.coordenador.first
        if @aluno.respostas.joins(:pergunta).where('perguntas.dimensao_id = ?', @dimensao_coordenador.id).empty?
          render :iniciar_respostas_coordenador
        else
          flash[:sucesso] = 'Você concluiu a sua pesquisa com sucesso !'
          render :action => 'responder_pesquisa', :id => @pesquisa.id
        end
      end
    end
  end
  
  def enviar_respostas
    unless params[:respostas]
      flash[:atencao] = "Você deve iniciar a pesquisa por esta página"
      redirect_to :action => "responder_pesquisa"
      return 
    end

    params[:respostas].each do |k, resposta|
      Resposta.create(resposta)
    end
    redirect_to :action => 'iniciar_respostas', :id => params[:id], :matricula => params[:matricula]
  end
  
  private 
  def valida_respostas?(params)
    unless params[:id]
      flash[:atencao] = "Você deve iniciar a pesquisa por esta página"
      redirect_to :action => "responder_pesquisa"
      return false
    end
    
    if not params[:matricula] or params[:matricula].empty?
      flash[:erro] = "Você deve obrigatoriamente informar a sua matrícula"
      redirect_to :action => "responder_pesquisa"
      return false
    end
    
    unless Pesquisa.exists?(params[:id])
      flash[:erro] = "Não foi encontrada uma pesquisa com o id #{params[:id]}."
      redirect_to :action => "responder_pesquisa"
      return false
    end
    
    @pesquisa = Pesquisa.find(params[:id])
    
    unless Aluno.where(:matricula => params[:matricula]).exists?
      flash[:erro] = "Não foi encontrado um aluno com a matrícula #{params[:matricula]}."
      redirect_to :action => "responder_pesquisa"
      return false
    end
    
    @aluno = Aluno.where(:matricula => params[:matricula]).first
  end
end
