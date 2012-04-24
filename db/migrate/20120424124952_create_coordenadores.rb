class CreateCoordenadores < ActiveRecord::Migration
  def change
    create_table :coordenadores do |t|
      t.string :nome
      t.references :curso
      t.references :usuario

      t.timestamps
    end
    add_index :coordenadores, :curso_id
    add_index :coordenadores, :usuario_id
  end
end
