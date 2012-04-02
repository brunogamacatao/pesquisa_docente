class CreateInstituicoes < ActiveRecord::Migration
  def change
    create_table :instituicoes do |t|
      t.string :nome
      t.string :sigla

      t.timestamps
    end
  end
end
