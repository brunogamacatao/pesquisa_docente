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
end
