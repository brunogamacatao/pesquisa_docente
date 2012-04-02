class CreatePerguntas < ActiveRecord::Migration
  def change
    create_table :perguntas do |t|
      t.string :pergunta
      t.integer :ordem
      t.integer :pesquisa_id

      t.timestamps
    end
  end
end
