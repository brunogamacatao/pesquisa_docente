PesquisaDocente::Application.routes.draw do
  namespace :eleicao do resources :eleicoes end

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :usuarios

  root :to => 'responder_pesquisa#responder_pesquisa'
  
  match '/crossdomain'                    => 'responder_pesquisa#crossdomain'
  match 'responder_pesquisa'              => 'responder_pesquisa#responder_pesquisa'
  match 'responder_pesquisa/:id'          => 'responder_pesquisa#responder_pesquisa'
  match 'iniciar_respostas'               => 'responder_pesquisa#iniciar_respostas'
  match 'enviar_respostas'                => 'responder_pesquisa#enviar_respostas'
  match 'resultado'                       => 'resultados#index'
  match 'resultado/:id'                   => 'resultados#resultado_por_instituicao'
  match 'resultado_por_curso/:id'         => 'resultados#resultado_por_curso'
  match 'resultado_coordenador_curso/:id' => 'resultados#resultado_coordenador_curso'
  match 'resultado_por_turma/:id'         => 'resultados#resultado_por_turma'
  match 'resultado/falta_instituicao/:id' => 'resultados#alunos_que_faltam_por_instituicao'
  match 'resultado/falta_curso/:id'       => 'resultados#alunos_que_faltam_por_curso'
  match 'resultado/falta_turma/:id'       => 'resultados#alunos_que_faltam_por_turma'
  match "/delayed_job"                    => DelayedJobWeb, :anchor => false
  match "get_aluno/:id"                   => 'alunos#get_aluno'
  match "pode_votar/:id/:eleicao_id"      => 'alunos#pode_votar'
  
  resources :perguntas
  resources :pesquisas
  resources :coordenadores
  resources :cursos
  resources :alunos
  
  namespace :eleicao do
    resources :chapas
    match ''                   => 'eleicao#index'
    match 'escolher_chapa'     => 'eleicao#escolher_chapa'
    match 'confirmar'          => 'eleicao#confirmar'
    match 'list'               => 'eleicao#list'
    match 'chapas/eleicao/:id' => 'chapas#eleicao'
  end
end
