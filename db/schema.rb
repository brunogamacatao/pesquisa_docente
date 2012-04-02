# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120402144757) do

  create_table "alunos", :force => true do |t|
    t.string   "nome"
    t.string   "matricula"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "alunos_turmas", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "aluno_id"
    t.integer  "turma_id"
  end

  create_table "cursos", :force => true do |t|
    t.string   "nome"
    t.integer  "instituicao_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "disciplinas", :force => true do |t|
    t.string   "nome"
    t.integer  "curso_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "instituicoes", :force => true do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "perguntas", :force => true do |t|
    t.string   "pergunta"
    t.integer  "ordem"
    t.integer  "pesquisa_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pesquisas", :force => true do |t|
    t.string   "nome"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "professores", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resposta", :force => true do |t|
    t.integer  "nota"
    t.integer  "pergunta_id"
    t.integer  "aluno_id"
    t.integer  "turma_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "respostas", :force => true do |t|
    t.integer  "nota"
    t.integer  "pergunta_id"
    t.integer  "turma_id"
    t.integer  "aluno_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "turmas", :force => true do |t|
    t.string   "turno"
    t.string   "horario"
    t.integer  "professor_id"
    t.integer  "disciplina_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
