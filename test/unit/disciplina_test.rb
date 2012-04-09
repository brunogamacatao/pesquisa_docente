# == Schema Information
#
# Table name: disciplinas
#
#  id         :integer(4)      not null, primary key
#  nome       :string(255)
#  curso_id   :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class DisciplinaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
