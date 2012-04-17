# == Schema Information
#
# Table name: pesquisas
#
#  id         :integer(4)      not null, primary key
#  nome       :string(255)
#  slug       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Pesquisa < ActiveRecord::Base
  has_many :perguntas
  
  validates :nome, :slug, :presence => true
  validates :slug, :uniqueness => true
  
  accepts_nested_attributes_for :perguntas
  
  attr_accessible :nome, :slug, :perguntas_attributes
  
  def media_geral
    soma_respostas = 0
    perguntas.each do |pergunta|
      soma_respostas += pergunta.media_geral
    end
    soma_respostas / perguntas.count
  end
  
  def media_por_instituicao(instituicao)
    soma_respostas = 0
    perguntas.each do |pergunta|
      soma_respostas += pergunta.media_por_instituicao(instituicao)
    end
    soma_respostas / perguntas.count
  end
  
  def media_por_curso(curso)
    soma_respostas = 0
    perguntas.each do |pergunta|
      soma_respostas += pergunta.media_por_curso(curso)
    end
    soma_respostas / perguntas.count
  end
  
  def media_por_turma(turma)
    soma_respostas = 0
    perguntas.each do |pergunta|
      soma_respostas += pergunta.media_por_turma(turma)
    end
    soma_respostas / perguntas.count
  end
end
