class AddAtivaToPesquisa < ActiveRecord::Migration
  def up
    add_column :pesquisas, :ativa, :boolean
    execute <<-SQL
      UPDATE pesquisas SET ativa = 0
    SQL
  end
  
  def down
    remove_column :pesquisas, :ativa
  end
end
