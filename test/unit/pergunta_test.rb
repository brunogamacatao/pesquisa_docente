# == Schema Information
#
# Table name: perguntas
#
#  id          :integer(4)      not null, primary key
#  pergunta    :string(255)
#  ordem       :integer(4)
#  pesquisa_id :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'test_helper'

class PerguntaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
