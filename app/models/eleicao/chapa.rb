class Eleicao::Chapa < ActiveRecord::Base
  mount_uploader :imagem, ImagemUploader
  has_many :votos
end
