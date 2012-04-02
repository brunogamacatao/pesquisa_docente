class Pergunta < ActiveRecord::Base
  has_many :respostas
  belongs_to :pesquisa
  
  validates :pergunta, :ordem, :presence => true
  validates :ordem, :numericality => true
end
