class CreateObservacoes < ActiveRecord::Migration
  def change
    create_table :observacoes do |t|
      t.references :aluno
      t.references :turma
      t.references :professor
      t.text :observacoes

      t.timestamps
    end
    add_index :observacoes, :aluno_id
    add_index :observacoes, :turma_id
    add_index :observacoes, :professor_id
  end
end
