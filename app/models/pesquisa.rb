class Pesquisa < ActiveRecord::Base
  has_many :perguntas
  
  validates :nome, :slug, :presence => true
  validates :slug, :uniqueness => true
  
  accepts_nested_attributes_for :perguntas
  
  attr_accessible :nome, :slug, :perguntas_attributes
end
