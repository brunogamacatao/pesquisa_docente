# == Schema Information
#
# Table name: eleicao_chapas
#
#  id         :integer(4)      not null, primary key
#  nome       :string(255)
#  descricao  :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  imagem     :string(255)
#

class Eleicao::Chapa < ActiveRecord::Base
  mount_uploader :imagem, ImagemUploader
  has_many :votos
end
