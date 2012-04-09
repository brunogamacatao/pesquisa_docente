# == Schema Information
#
# Table name: respostas
#
#  id          :integer(4)      not null, primary key
#  nota        :integer(4)
#  pergunta_id :integer(4)
#  turma_id    :integer(4)
#  aluno_id    :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'test_helper'

class RespostaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
