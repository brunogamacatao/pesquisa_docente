class Aluno < ActiveRecord::Base
  has_and_belongs_to_many :turmas
  has_many :respostas
  
  validates :nome, :matricula, :presence => true
end
