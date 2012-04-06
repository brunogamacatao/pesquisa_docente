require 'set'

class Curso < ActiveRecord::Base
  belongs_to :instituicao
  has_many :disciplinas
  
  validates :nome, :presence => true
  validates :nome, :uniqueness => true
  
  def turmas
    turmas = Set.new
    self.disciplinas.each do |disciplina|
      turmas.merge(disciplina.turmas)
    end
    turmas
  end
  
  def total_alunos
    result = connection.select_one "SELECT COUNT(*) AS total FROM
    (SELECT DISTINCT a.id 
    FROM cursos c 
    INNER JOIN disciplinas d ON d.curso_id = c.id 
    INNER JOIN turmas t ON t.disciplina_id = d.id 
    INNER JOIN alunos_turmas at ON at.turma_id = t.id 
    INNER JOIN alunos a ON at.aluno_id = a.id
    WHERE c.id = #{self.id}) t"
    result["total"]
  end
  
  def total_alunos_responderam
    result = connection.select_one "SELECT COUNT(*) AS total FROM
    (SELECT DISTINCT a.id 
    FROM cursos c 
    INNER JOIN disciplinas d ON d.curso_id = c.id 
    INNER JOIN turmas t ON t.disciplina_id = d.id 
    INNER JOIN alunos_turmas at ON at.turma_id = t.id 
    INNER JOIN alunos a ON at.aluno_id = a.id
    INNER JOIN respostas r ON r.aluno_id = a.id
    WHERE c.id = #{self.id}) t"
    result["total"]
  end
  
  def percentual_responderam
    (self.total_alunos != 0 && self.total_alunos_responderam / self.total_alunos) || 0
  end
end
