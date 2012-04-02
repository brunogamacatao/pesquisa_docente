class Aluno < ActiveRecord::Base
  has_and_belongs_to_many :turmas
  
  validates :nome, :matricula, :presence => true
end
