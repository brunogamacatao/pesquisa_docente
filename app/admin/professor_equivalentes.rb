ActiveAdmin.register ProfessorEquivalente do
  collection_action :autocomplete_professor_nome,  :method => :get
  collection_action :autocomplete_disciplina_nome, :method => :get

  controller do
    autocomplete :disciplina, :nome, :full => true
    autocomplete :professor,  :nome, :full => true
  end
  
  form do |f|
    f.inputs "Professor" do
      f.input :professor,  :as => :autocomplete, :url => autocomplete_professor_nome_admin_professor_equivalentes_path
    end
    f.inputs "Disicplina" do
      f.input :disciplina, :as => :autocomplete, :url => autocomplete_disciplina_nome_admin_professor_equivalentes_path
    end
    f.buttons
  end
end
