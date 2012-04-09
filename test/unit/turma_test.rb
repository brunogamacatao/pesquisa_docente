# == Schema Information
#
# Table name: turmas
#
#  id            :integer(4)      not null, primary key
#  turno         :string(255)
#  horario       :string(255)
#  professor_id  :integer(4)
#  disciplina_id :integer(4)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'test_helper'

class TurmaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
