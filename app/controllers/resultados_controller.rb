class ResultadosController < ApplicationController
  before_filter :authenticate_usuario!
  
  def index
    if current_usuario.coordenador
      redirect_to :action => :resultado_por_curso, :id => current_usuario.coordenador.curso.id
    else
      @pesquisa        = Pesquisa.ativa(:order => 'created_at DESC').first
      @dimensoes       = @pesquisa.dimensoes
      @instituicoes    = Instituicao.order(:nome)
      @total_alunos    = 0
      @total_respostas = 0
    
      @instituicoes.each do |instituicao|
        @total_alunos    += instituicao.total_alunos
        @total_respostas += instituicao.total_alunos_responderam
      end
    
      @percentual = (@total_alunos > 0 && (@total_respostas / @total_alunos)) || 0
    
      respond_to do |format|
        format.html
        format.pdf do
          pdf = ResultadoGeralPdf.new(@pesquisa, @dimensoes, @total_respostas, @total_alunos, view_context)
          send_data pdf.render, filename: "resultado_geral.pdf", type: "application/pdf", disposition: "inline"
        end
        format.csv do
          respostas = CSV.generate do |csv|
            linha         = []
            ids_perguntas = []
          
            @pesquisa.dimensoes.each do |dimensao|
              dimensao.perguntas.order("ordem").each do |pergunta|
                linha << pergunta.ordem
                ids_perguntas << pergunta.id
              end
            end
            csv << linha
          
            Aluno.all.each do |aluno|
              resposta = [] 
              qtd = 0
              ids_perguntas.each do |pergunta_id|
                r = Resposta.where("aluno_id = ? AND pergunta_id = ?", aluno.id, pergunta_id).first
                if r
                  resposta << r.nota
                  qtd += 1
                else
                  resposta << '-'
                end
              end
              csv << resposta if qtd > 0
            end # end each
          end # end CSV
          
          send_data respostas
        end # end format
      end # end respond_to
    end # end if
  end # end def
  
  def resultado_por_instituicao
    if current_usuario.coordenador
      redirect_to :action => :resultado_por_curso, :id => current_usuario.coordenador.curso.id
    else
      @pesquisa    = Pesquisa.ativa(:order => 'created_at DESC').first
      @dimensoes   = @pesquisa.dimensoes
      @instituicao = Instituicao.find(params[:id])
    
      respond_to do |format|
        format.html
        format.pdf do
          pdf = ResultadoInstituicaoPdf.new(@pesquisa, @dimensoes, @instituicao, view_context)
          send_data pdf.render, filename: "resultado_#{@instituicao.sigla}.pdf", type: "application/pdf", disposition: "inline"
        end
        format.csv do
          respostas = CSV.generate do |csv|
            linha         = []
            ids_perguntas = []
          
            @pesquisa.dimensoes.each do |dimensao|
              dimensao.perguntas.order("ordem").each do |pergunta|
                linha << pergunta.ordem
                ids_perguntas << pergunta.id
              end
            end
            csv << linha
          
            $redis.smembers(@instituicao.redis_key(:alunos_responderam)).each do |aluno_id|
              resposta = [] 
              qtd = 0
              ids_perguntas.each do |pergunta_id|
                r = Resposta.where("aluno_id = ? AND pergunta_id = ?", aluno_id, pergunta_id).first
                if r
                  resposta << r.nota
                  qtd += 1
                else
                  resposta << '-'
                end
              end
              csv << resposta if qtd > 0
            end # end each
          end # end CSV
          
          send_data respostas
        end # end format
      end
    end
  end
  
  def resultado_por_curso
    @pesquisa  = Pesquisa.ativa(:order => 'created_at DESC').first
    @dimensoes = @pesquisa.dimensoes
    @curso     = Curso.find(params[:id])
    
    authorize! :ver, @curso
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ResultadoCursoPdf.new(@pesquisa, @dimensoes, @curso, view_context)
        send_data pdf.render, filename: "resultado_#{@curso.nome}.pdf", type: "application/pdf", disposition: "inline"
      end
      format.csv do
        respostas = CSV.generate do |csv|
          linha         = []
          ids_perguntas = []
        
          @pesquisa.dimensoes.each do |dimensao|
            dimensao.perguntas.order("ordem").each do |pergunta|
              linha << pergunta.ordem
              ids_perguntas << pergunta.id
            end
          end
          csv << linha
        
          $redis.smembers(@curso.redis_key(:alunos_responderam)).each do |aluno_id|
            resposta = [] 
            qtd = 0
            ids_perguntas.each do |pergunta_id|
              r = Resposta.where("aluno_id = ? AND pergunta_id = ?", aluno_id, pergunta_id).first
              if r
                resposta << r.nota
                qtd += 1
              else
                resposta << '-'
              end
            end
            csv << resposta if qtd > 0
          end # end each
        end # end CSV
        
        send_data respostas
      end # end format

    end
  end
  
  def resultado_por_turma
    @pesquisa  = Pesquisa.ativa(:order => 'created_at DESC').first
    @perguntas = @pesquisa.perguntas.order(:ordem)
    @turma     = Turma.find(params[:id])
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ResultadoTurmaPdf.new(@pesquisa, @perguntas, @turma, view_context)
        send_data pdf.render, filename: "resultado_#{@turma.disciplina.nome}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end
  
  def alunos_que_faltam_por_instituicao
    @alunos = Instituicao.find(params[:id]).alunos_faltam_responder
    render :lista_alunos
  end
  
  def alunos_que_faltam_por_curso
    @alunos = Curso.find(params[:id]).alunos_faltam_responder
    render :lista_alunos
  end
  
  def alunos_que_faltam_por_turma
    @alunos = Turma.find(params[:id]).alunos_faltam_responder
    render :lista_alunos
  end
end
