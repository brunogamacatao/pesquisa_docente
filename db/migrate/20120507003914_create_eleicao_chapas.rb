class CreateEleicaoChapas < ActiveRecord::Migration
  def change
    create_table :eleicao_chapas do |t|
      t.string :nome
      t.text :descricao

      t.timestamps
    end
  end
end
