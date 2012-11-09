class UpdateTipoOfDimensao < ActiveRecord::Migration
  def up
    change_column :dimensoes, :tipo, :integer, :default => 0
    execute <<-SQL
      UPDATE dimensoes SET tipo = 0
    SQL
  end
end
