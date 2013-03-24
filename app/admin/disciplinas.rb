ActiveAdmin.register Disciplina do
  collection_action :autocomplete_disciplina_nome, :method => :get

  controller do
    autocomplete :disciplina, :nome, :full => true
  end

  filter :nome_contains, :as => :autocomplete, :url => '/admin/disciplinas/autocomplete_disciplina_nome',
                          :label => "Procurar Disciplina", :required => false, :wrapper_html => {:style => "list-style: none"}

end
