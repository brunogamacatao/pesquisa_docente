class Professor < ActiveRecord::Base
  has_many :turmas
  
  validates :nome, :presence => true
end
