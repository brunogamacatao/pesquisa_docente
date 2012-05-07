PesquisaDocente::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :usuarios

  root :to => 'responder_pesquisa#responder_pesquisa'
  
  match 'responder_pesquisa'              => 'responder_pesquisa#responder_pesquisa'
  match 'responder_pesquisa/:id'          => 'responder_pesquisa#responder_pesquisa'
  match 'iniciar_respostas'               => 'responder_pesquisa#iniciar_respostas'
  match 'enviar_respostas'                => 'responder_pesquisa#enviar_respostas'
  match 'resultado'                       => 'resultados#index'
  match 'resultado/:id'                   => 'resultados#resultado_por_instituicao'
  match 'resultado_por_curso/:id'         => 'resultados#resultado_por_curso'
  match 'resultado_por_turma/:id'         => 'resultados#resultado_por_turma'
  match 'resultado/falta_instituicao/:id' => 'resultados#alunos_que_faltam_por_instituicao'
  match 'resultado/falta_curso/:id'       => 'resultados#alunos_que_faltam_por_curso'
  match 'resultado/falta_turma/:id'       => 'resultados#alunos_que_faltam_por_turma'
  
  resources :perguntas
  resources :pesquisas
  resources :coordenadores
  
  namespace :eleicao do
    resources :chapas
    match ''          => 'eleicao#index'
    match 'confirmar' => 'eleicao#confirmar'
  end
end
