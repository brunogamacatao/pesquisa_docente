class Turma < ActiveRecord::Base
  has_and_belongs_to_many :alunos
  belongs_to :professor
  belongs_to :disciplina
  
  validates :turno, :horario, :presence => true
end
