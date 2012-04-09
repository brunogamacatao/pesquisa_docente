# == Schema Information
#
# Table name: turmas
#
#  id            :integer(4)      not null, primary key
#  turno         :string(255)
#  horario       :string(255)
#  professor_id  :integer(4)
#  disciplina_id :integer(4)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Turma < ActiveRecord::Base
  @@total_alunos_cache       = {}
  @@total_alunos_responderam = {}
  
  has_and_belongs_to_many :alunos
  belongs_to :professor
  belongs_to :disciplina
  
  validates :turno, :horario, :presence => true
  
  def self.invalidate_cache(id)
    @@total_alunos_cache.delete(id)
    @@total_alunos_responderam.delete(id)
  end
  
  def total_alunos
    @@total_alunos_cache[self.id] ||= self.calcula_total_alunos()
  end

  def total_alunos_responderam
    @@total_alunos_responderam[self.id] ||= self.calcula_total_alunos_responderam()
  end
  
  def percentual_responderam
    (self.total_alunos != 0 && 100 * self.total_alunos_responderam / self.total_alunos) || 0
  end
  
  def calcula_total_alunos
    self.alunos.count
  end
  
  def calcula_total_alunos_responderam
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
end
