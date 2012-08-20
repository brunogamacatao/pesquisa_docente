# == Schema Information
#
# Table name: coordenadores
#
#  id         :integer(4)      not null, primary key
#  nome       :string(255)
#  curso_id   :integer(4)
#  usuario_id :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Coordenador < ActiveRecord::Base
  belongs_to :curso
  belongs_to :usuario
  
  accepts_nested_attributes_for :usuario
end
