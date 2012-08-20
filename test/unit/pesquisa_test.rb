# == Schema Information
#
# Table name: pesquisas
#
#  id         :integer(4)      not null, primary key
#  nome       :string(255)
#  slug       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  ativa      :boolean(1)
#

require 'test_helper'

class PesquisaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
