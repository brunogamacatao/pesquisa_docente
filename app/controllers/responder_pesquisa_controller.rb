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
        @pesquisa = Pesquisa.ativa(:order => 'created_at DESC').first
      end
    end
  end
  
  def iniciar_respostas
    unless params[:id]
      flash[:atencao] = "Você deve iniciar a pesquisa por esta página"
      redirect_to :action => "responder_pesquisa"
      return 
    end
    
    if not params[:matricula] or params[:matricula].empty?
      flash[:erro] = "Você deve obrigatoriamente informar a sua matrícula"
      redirect_to :action => "responder_pesquisa"
      return 
    end
    
    @pesquisa = Pesquisa.find(params[:id])
    @aluno    = Aluno.find(:first, :conditions => {:matricula => params[:matricula]})
    
    unless @aluno
      flash[:erro] = "Não foi encontrado um aluno com a matrícula #{params[:matricula]}."
      redirect_to :action => "responder_pesquisa"
      return 
    end
    
    if @pesquisa.tipo_resposta == TipoResposta::UMA_RESPOSTA_POR_ALUNO
      ja_respondeu = false
      @aluno.respostas.each do |resposta|
        if resposta.pergunta.dimensao.pesquisa.id == @pesquisa.id
          ja_respondeu = true
          break
        end
      end
      
      unless ja_respondeu
        render :iniciar_respostas_unicas
      else
        flash[:sucesso] = 'Você concluiu a sua pesquisa com sucesso !'
        render :action => 'responder_pesquisa', :id => @pesquisa.id
      end
    else
      turmas = @aluno.turmas.clone
      @total = turmas.count
      @atual = 0
    
      # O laço abaixo conta para quantas turmas o aluno tem respostas
      @aluno.respostas.each do |resposta|
        @atual += 1 if turmas.delete(resposta.turma)
      end
    
      # A partir da quantidade é calculada a porcentagem respondida
      @atual += 1
      @progresso = @atual.to_f / @total.to_f * 100.0 if @total > 0
    
      # Caso ainda existam turmas, será escolhida a primeira para o aluno responder
      unless turmas.empty?
        @turma = turmas[0]
      else # Caso contrário, a pesquisa está concluída
        flash[:sucesso] = 'Você concluiu a sua pesquisa com sucesso !'
        render :action => 'responder_pesquisa', :id => @pesquisa.id
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
end
