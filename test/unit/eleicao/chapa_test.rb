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

require 'test_helper'

class Eleicao::ChapaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
