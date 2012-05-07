class Eleicao::Chapa < ActiveRecord::Base
  mount_uploader :imagem, ImagemUploader
end
