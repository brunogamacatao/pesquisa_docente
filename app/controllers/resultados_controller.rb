class ResultadosController < ApplicationController
  before_filter :authenticate_usuario!
  
  def index
    if current_usuario.coordenador
      redirect_to :action => :resultado_por_curso, :id => current_usuario.coordenador.curso.id
    else
      @pesquisa        = Pesquisa.last
      @perguntas       = @pesquisa.perguntas.order(:ordem)
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
          pdf = ResultadoGeralPdf.new(@pesquisa, @perguntas, @total_respostas, @total_alunos, view_context)
          send_data pdf.render, filename: "resultado_geral.pdf", type: "application/pdf", disposition: "inline"
        end
      end
    end
  end
  
  def resultado_por_instituicao
    if current_usuario.coordenador
      redirect_to :action => :resultado_por_curso, :id => current_usuario.coordenador.curso.id
    else
      @pesquisa    = Pesquisa.last
      @perguntas   = @pesquisa.perguntas.order(:ordem)
      @instituicao = Instituicao.find(params[:id])
    
      respond_to do |format|
        format.html
        format.pdf do
          pdf = ResultadoInstituicaoPdf.new(@pesquisa, @perguntas, @instituicao, view_context)
          send_data pdf.render, filename: "resultado_#{@instituicao.sigla}.pdf", type: "application/pdf", disposition: "inline"
        end
      end
    end
  end
  
  def resultado_por_curso
    @pesquisa  = Pesquisa.last
    @perguntas = @pesquisa.perguntas.order(:ordem)
    @curso     = Curso.find(params[:id])
    
    authorize! :ver, @curso
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ResultadoCursoPdf.new(@pesquisa, @perguntas, @curso, view_context)
        send_data pdf.render, filename: "resultado_#{@curso.nome}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end
  
  def resultado_por_turma
    @pesquisa  = Pesquisa.last
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
