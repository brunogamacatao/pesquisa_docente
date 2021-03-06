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

ActiveRecord::Schema.define(:version => 20130325003850) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "alunos", :force => true do |t|
    t.string   "nome"
    t.string   "matricula"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "alunos_turmas", :force => true do |t|
    t.integer  "aluno_id"
    t.integer  "turma_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "coordenadores", :force => true do |t|
    t.string   "nome"
    t.integer  "curso_id"
    t.integer  "usuario_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "coordenadores", ["curso_id"], :name => "index_coordenadores_on_curso_id"
  add_index "coordenadores", ["usuario_id"], :name => "index_coordenadores_on_usuario_id"

  create_table "cursos", :force => true do |t|
    t.string   "nome"
    t.integer  "instituicao_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "dimensoes", :force => true do |t|
    t.string   "nome"
    t.integer  "pesquisa_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "tipo",        :default => 0
  end

  add_index "dimensoes", ["pesquisa_id"], :name => "index_dimensoes_on_pesquisa_id"

  create_table "disciplinas", :force => true do |t|
    t.string   "nome"
    t.integer  "curso_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "eleicao_chapas", :force => true do |t|
    t.string   "nome"
    t.text     "descricao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "imagem"
    t.integer  "eleicao_id"
  end

  add_index "eleicao_chapas", ["eleicao_id"], :name => "index_eleicao_chapas_on_eleicao_id"

  create_table "eleicao_eleicoes", :force => true do |t|
    t.string   "nome"
    t.integer  "curso_id"
    t.integer  "brancos"
    t.integer  "nulos"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "eleicao_eleicoes", ["curso_id"], :name => "index_eleicao_eleicoes_on_curso_id"

  create_table "eleicao_votos", :force => true do |t|
    t.integer  "aluno_id"
    t.integer  "chapa_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "eleicao_votos", ["aluno_id"], :name => "index_eleicao_votos_on_aluno_id"
  add_index "eleicao_votos", ["chapa_id"], :name => "index_eleicao_votos_on_chapa_id"

  create_table "instituicoes", :force => true do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "observacoes", :force => true do |t|
    t.integer  "aluno_id"
    t.integer  "turma_id"
    t.integer  "professor_id"
    t.text     "observacoes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "observacoes", ["aluno_id"], :name => "index_observacoes_on_aluno_id"
  add_index "observacoes", ["professor_id"], :name => "index_observacoes_on_professor_id"
  add_index "observacoes", ["turma_id"], :name => "index_observacoes_on_turma_id"

  create_table "perguntas", :force => true do |t|
    t.string   "pergunta"
    t.integer  "ordem"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "dimensao_id"
  end

  add_index "perguntas", ["dimensao_id"], :name => "index_perguntas_on_dimensao_id"

  create_table "pesquisas", :force => true do |t|
    t.string   "nome"
    t.string   "slug"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "ativa"
    t.integer  "tipo_resposta"
  end

  create_table "professor_equivalentes", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "disciplina_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "professor_equivalentes", ["disciplina_id"], :name => "index_professor_equivalentes_on_disciplina_id"
  add_index "professor_equivalentes", ["professor_id"], :name => "index_professor_equivalentes_on_professor_id"

  create_table "professores", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "usuarios", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

end
