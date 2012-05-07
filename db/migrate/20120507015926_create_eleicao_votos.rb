class CreateEleicaoVotos < ActiveRecord::Migration
  def change
    create_table :eleicao_votos do |t|
      t.references :aluno
      t.references :chapa

      t.timestamps
    end
    add_index :eleicao_votos, :aluno_id
    add_index :eleicao_votos, :chapa_id
  end
end
