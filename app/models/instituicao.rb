class Instituicao < ActiveRecord::Base
  has_many :cursos
  
  validates :nome, :sigla, :presence => true
  validates :sigla, :uniqueness => true
  
  def total_alunos
    total = 0
    self.cursos.each {|curso| total += curso.total_alunos}
    total
  end
  
  def total_alunos_responderam
    total = 0
    self.cursos.each {|curso| total += curso.total_alunos_responderam}
    total
  end
  
  def percentual_responderam
    self.total_alunos_responderam / self.total_alunos
  end
end
