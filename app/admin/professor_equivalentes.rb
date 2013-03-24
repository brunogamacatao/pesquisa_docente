ActiveAdmin.register ProfessorEquivalente do
  collection_action :autocomplete_disciplina_nome, :method => :get

  controller do
    autocomplete :disciplina, :nome, :full => true
  end
  
  form do |f|
    f.input :disciplina, :as => :autocomplete, :url => autocomplete_disciplina_nome_admin_professor_equivalentes_path
  end
end
