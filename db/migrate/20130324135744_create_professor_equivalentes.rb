class CreateProfessorEquivalentes < ActiveRecord::Migration
  def change
    create_table :professor_equivalentes do |t|
      t.references :professor
      t.references :disciplina

      t.timestamps
    end
    add_index :professor_equivalentes, :professor_id
    add_index :professor_equivalentes, :disciplina_id
  end
end
