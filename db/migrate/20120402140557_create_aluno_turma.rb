class CreateAlunoTurma < ActiveRecord::Migration
  def up
    create_table :alunos_turmas do |t|
      t.integer :aluno_id
      t.integer :turma_id

      t.timestamps
    end
  end

  def down
    drop_table :alunos_turmas
  end
end
