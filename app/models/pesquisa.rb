# encoding: utf-8
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
  include PesquisaDocente::TipoResposta
  include PesquisaDocente::Estatisticas
  
  scope :ativa, where(:ativa => true).order('created_at DESC')
  
  has_many :dimensoes
  
  validates :nome, :slug, :tipo_resposta, :presence => true
  validates :slug, :uniqueness => true
  
  accepts_nested_attributes_for :dimensoes
  attr_accessible :nome, :slug, :ativa, :tipo_resposta, :dimensoes_attributes
  
  after_save :atualiza_atributo_ativa
  
  private
    def atualiza_atributo_ativa
     Pesquisa.update_all({:ativa => false}, ["id <> ?", id]) if ativa
    end
end
