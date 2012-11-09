class AddTipoToDimensao < ActiveRecord::Migration
  def change
    add_column :dimensoes, :tipo, :integer

  end
end
