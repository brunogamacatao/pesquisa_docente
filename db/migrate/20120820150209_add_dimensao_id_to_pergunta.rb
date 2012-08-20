class AddDimensaoIdToPergunta < ActiveRecord::Migration
  def change
    add_column :perguntas, :dimensao_id, :integer
    add_index :perguntas, :dimensao_id
  end
end
