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
end
