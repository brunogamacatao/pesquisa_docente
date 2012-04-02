class CreateTurmas < ActiveRecord::Migration
  def change
    create_table :turmas do |t|
      t.string :turno
      t.string :horario
      t.integer :professor_id
      t.integer :disciplina_id

      t.timestamps
    end
  end
end
