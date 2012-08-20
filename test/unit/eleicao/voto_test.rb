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

require 'test_helper'

class Eleicao::VotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
