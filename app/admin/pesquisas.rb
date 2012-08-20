ActiveAdmin.register Pesquisa do
  scope :ativa
  
  index do
    column :nome
    column :ativa
    default_actions
  end
  
  form do |f|
    f.inputs "Dados da Pesquisa" do
      f.input :nome
      f.input :slug
      f.input :ativa
      f.inputs "Dimensoes" do
        f.has_many :dimensoes, :header => "" do |dimensao|
          dimensao.input :nome
          dimensao.has_many :perguntas, :header => "" do |pergunta|
            pergunta.input :ordem
            pergunta.input :pergunta
          end
        end
      end
    end
    f.buttons
  end
end
