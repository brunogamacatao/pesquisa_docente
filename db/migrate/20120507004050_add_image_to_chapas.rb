class AddImageToChapas < ActiveRecord::Migration
  def change
    add_column :eleicao_chapas, :imagem, :string

  end
end
