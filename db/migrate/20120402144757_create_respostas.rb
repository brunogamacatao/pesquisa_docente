class CreateRespostas < ActiveRecord::Migration
  def change
    create_table :respostas do |t|
      t.integer :nota
      t.integer :pergunta_id
      t.integer :turma_id
      t.integer :aluno_id

      t.timestamps
    end
  end
end
