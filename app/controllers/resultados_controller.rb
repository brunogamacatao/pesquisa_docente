class ResultadosController < ApplicationController
  def index
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
    @instituicao = Instituicao.find(params[:id])
  end
  
  def resultado_por_curso
    @curso = Curso.find(params[:id])
  end
end
