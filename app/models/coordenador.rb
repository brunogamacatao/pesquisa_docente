class Coordenador < ActiveRecord::Base
  belongs_to :curso
  belongs_to :usuario
  
  accepts_nested_attributes_for :usuario
end
