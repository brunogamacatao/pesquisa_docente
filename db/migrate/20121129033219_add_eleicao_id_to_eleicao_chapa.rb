class AddEleicaoIdToEleicaoChapa < ActiveRecord::Migration
  def change
    add_column :eleicao_chapas, :eleicao_id, :integer
    add_index :eleicao_chapas, :eleicao_id
  end
end
