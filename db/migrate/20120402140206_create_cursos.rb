class CreateCursos < ActiveRecord::Migration
  def change
    create_table :cursos do |t|
      t.string :nome
      t.integer :instituicao_id

      t.timestamps
    end
  end
end
