class Instituicao < ActiveRecord::Base
  has_many :cursos
  
  validates :nome, :sigla, :presence => true
  validates :sigla, :uniqueness => true
  
  def total_alunos
    result = connection.select_one "SELECT COUNT(*) AS total FROM
    (SELECT DISTINCT a.id 
    FROM instituicoes i
    INNER JOIN cursos c ON c.instituicao_id = i.id
    INNER JOIN disciplinas d ON d.curso_id = c.id 
    INNER JOIN turmas t ON t.disciplina_id = d.id 
    INNER JOIN alunos_turmas at ON at.turma_id = t.id 
    INNER JOIN alunos a ON at.aluno_id = a.id
    WHERE i.id = #{self.id}) t"
    result["total"]
  end
  
  def total_alunos_responderam
    result = connection.select_one "SELECT COUNT(*) AS total FROM
    (SELECT DISTINCT a.id 
    FROM instituicoes i
    INNER JOIN cursos c ON c.instituicao_id = i.id
    INNER JOIN disciplinas d ON d.curso_id = c.id 
    INNER JOIN turmas t ON t.disciplina_id = d.id 
    INNER JOIN alunos_turmas at ON at.turma_id = t.id 
    INNER JOIN alunos a ON at.aluno_id = a.id
    INNER JOIN respostas r ON r.aluno_id = a.id
    WHERE i.id = #{self.id}) t"
    result["total"]
  end
  
  def percentual_responderam
    self.total_alunos_responderam / self.total_alunos
  end
end
