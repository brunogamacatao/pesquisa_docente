class CreatePesquisas < ActiveRecord::Migration
  def change
    create_table :pesquisas do |t|
      t.string :nome
      t.string :slug

      t.timestamps
    end
  end
end
