class CreateDimensoes < ActiveRecord::Migration
  def change
    create_table :dimensoes do |t|
      t.string :nome
      t.references :pesquisa

      t.timestamps
    end
    add_index :dimensoes, :pesquisa_id
  end
end
