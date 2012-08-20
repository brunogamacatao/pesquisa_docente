module TipoResposta
  UMA_RESPOSTA_POR_TURMA = 0
  UMA_RESPOSTA_POR_ALUNO = 1
  
  def nome_tipo_resposta
    return "" unless self[:tipo_resposta]
    value = self[:tipo_resposta]
    TipoResposta.constants[value].to_s.split('_').join(' ').downcase
  end
end

# == Schema Information
#
# Table name: pesquisas
#
#  id         :integer(4)      not null, primary key
#  nome       :string(255)
#  slug       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  ativa      :boolean(1)
#

class Pesquisa < ActiveRecord::Base
  scope :ativa, where(:ativa => true)
  
  has_many :dimensoes
  
  validates :nome, :slug, :tipo_resposta, :presence => true
  validates :slug, :uniqueness => true
  
  include TipoResposta
  
  accepts_nested_attributes_for :dimensoes
  attr_accessible :nome, :slug, :ativa, :tipo_resposta, :dimensoes_attributes
  
  after_save :atualiza_atributo_ativa
  
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
  
  private
    def atualiza_atributo_ativa
     Pesquisa.update_all({:ativa => false}, ["id <> ?", id]) if ativa
    end
end
