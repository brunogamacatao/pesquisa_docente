# == Schema Information
#
# Table name: dimensoes
#
#  id          :integer(4)      not null, primary key
#  nome        :string(255)
#  pesquisa_id :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'test_helper'

class DimensaoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
