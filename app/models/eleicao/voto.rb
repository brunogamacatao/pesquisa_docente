# == Schema Information
#
# Table name: eleicao_votos
#
#  id         :integer(4)      not null, primary key
#  aluno_id   :integer(4)
#  chapa_id   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Eleicao::Voto < ActiveRecord::Base
  belongs_to :aluno
  belongs_to :chapa
end
