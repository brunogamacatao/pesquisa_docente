class Eleicao::Voto < ActiveRecord::Base
  belongs_to :aluno
  belongs_to :chapa
end
