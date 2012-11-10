require 'set'

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
  
  def ja_respondeu_alguma?(pesquisa)
    self.respostas.da_pesquisa(pesquisa).count > 0
  end
  
  def turmas_respondeu(pesquisa)
    turmas_respondeu = Set.new
    self.respostas.da_pesquisa(pesquisa).each { |resposta| turmas_respondeu << resposta.turma if resposta.turma}
    turmas_respondeu
  end
  
  def turmas_falta_responder(pesquisa)
    self.turmas.clone - self.turmas_respondeu(pesquisa).to_a
  end
  
  def porcentagem_respostas(pesquisa)
    atual = self.turmas_respondeu(pesquisa).length + 1
    total = self.turmas.count
    atual.to_f / total.to_f * 100.0 if total > 0
  end
end
