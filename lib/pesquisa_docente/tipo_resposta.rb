module PesquisaDocente
  module TipoResposta
    UMA_RESPOSTA_POR_TURMA     = 0
    UMA_RESPOSTA_POR_ALUNO     = 1
    UMA_RESPOSTA_POR_PROFESSOR = 2

    def nome_tipo_resposta
      return "" unless self[:tipo_resposta]
      value = self[:tipo_resposta]
      TipoResposta.constants[value].to_s.split('_').join(' ').downcase
    end
  end
end