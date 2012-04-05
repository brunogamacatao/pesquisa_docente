class Turma < ActiveRecord::Base
  has_and_belongs_to_many :alunos
  belongs_to :professor
  belongs_to :disciplina
  
  validates :turno, :horario, :presence => true
  
  def total_alunos
    self.alunos.count
  end
  
  def total_alunos_responderam
    total = 0
    self.alunos.each do |aluno|
      aluno.respostas.each do |resposta|
        if resposta.turma.id == self.id
          total += 1
          break
        end
      end
    end
    total
  end
  
  def percentual_responderam
    (self.total_alunos != 0 && self.total_alunos_responderam / self.total_alunos) || 0
  end
  
end
