class RemovePesquisaIdFromPergunta < ActiveRecord::Migration
  def up
    remove_column :perguntas, :pesquisa_id
  end

  def down
    add_column :perguntas, :pesquisa_id, :integer
  end
end
