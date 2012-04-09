class ResultadosController < ApplicationController
  before_filter :authenticate_usuario!
  
  def index
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
  end
  
  def resultado_por_instituicao
    @pesquisa    = Pesquisa.last
    @perguntas   = @pesquisa.perguntas.order(:ordem)
    @instituicao = Instituicao.find(params[:id])
    
    gon.cursos = @instituicao.cursos
  end
  
  def resumo_curso
    @curso = Curso.find(params[:id])
    render :partial => "resultados/resumo_curso"
  end
  
  def resultado_por_curso
    @pesquisa  = Pesquisa.last
    @perguntas = @pesquisa.perguntas.order(:ordem)
    @curso     = Curso.find(params[:id])
  end
  
  def resultado_por_turma
    @pesquisa  = Pesquisa.last
    @perguntas = @pesquisa.perguntas.order(:ordem)
    @turma     = Turma.find(params[:id])
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
