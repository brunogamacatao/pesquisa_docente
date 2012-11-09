module TipoDimensao
  COMUM       = 0
  COORDENADOR = 1
end

# == Schema Information
#
# Table name: dimensoes
#
#  id          :integer(4)      not null, primary key
#  nome        :string(255)
#  tipo        :integer(11)
#  pesquisa_id :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Dimensao < ActiveRecord::Base
  belongs_to :pesquisa
  has_many :perguntas

  validates :nome, :presence => true

  accepts_nested_attributes_for :perguntas
  attr_accessible :nome, :perguntas_attributes, :tipo
  
  default_scope where(:tipo => TipoDimensao::COMUM)
end
