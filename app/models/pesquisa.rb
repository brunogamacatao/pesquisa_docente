class Pesquisa < ActiveRecord::Base
  has_many :perguntas
  
  validates :nome, :slug, :presence => true
  validates :slug, :uniqueness => true
end
