class UpdateValueTipoRespostaOfPesquisa < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE pesquisas SET tipo_resposta = 0
    SQL
  end
end
