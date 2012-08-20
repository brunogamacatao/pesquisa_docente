class AddTipoRespostaToPesquisa < ActiveRecord::Migration
  def change
    add_column :pesquisas, :tipo_resposta, :integer
  end
end
