class Resposta < ActiveRecord::Base
  belongs_to :pergunta
  belongs_to :aluno
  belongs_to :turma
  
  validates :nota, :aluno_id, :turma_id, :pergunta_id, :presence => true
  validates :nota, :numericality, :presence => true
end
