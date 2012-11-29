class CreateEleicaoEleicoes < ActiveRecord::Migration
  def change
    create_table :eleicao_eleicoes do |t|
      t.string :nome
      t.references :curso
      t.integer :brancos
      t.integer :nulos

      t.timestamps
    end
    add_index :eleicao_eleicoes, :curso_id
  end
end
