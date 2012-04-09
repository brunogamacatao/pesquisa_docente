# == Schema Information
#
# Table name: professores
#
#  id         :integer(4)      not null, primary key
#  nome       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Professor < ActiveRecord::Base
  has_many :turmas
  
  validates :nome, :presence => true
end
