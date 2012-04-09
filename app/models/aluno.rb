# == Schema Information
#
# Table name: alunos
#
#  id         :integer(4)      not null, primary key
#  nome       :string(255)
#  matricula  :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Aluno < ActiveRecord::Base
  has_and_belongs_to_many :turmas
  has_many :respostas
  
  validates :nome, :matricula, :presence => true
end
