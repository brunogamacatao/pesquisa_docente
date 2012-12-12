module PesquisaDocente
  module Estatisticas
    def media_geral
      soma_respostas = 0
      qtd_perguntas  = 0
      
      dimensoes.each do |dimensao|
        dimensao.perguntas.each do |pergunta|
          soma_respostas += pergunta.media_geral
          qtd_perguntas  += 1
        end
      end
      
      qtd_perguntas > 0 ? (soma_respostas / qtd_perguntas) : 0
    end
    
    def media_por_instituicao(instituicao)
      soma_respostas = 0
      qtd_perguntas  = 0
      
      dimensoes.each do |dimensao|
        dimensao.perguntas.each do |pergunta|
          soma_respostas += pergunta.media_por_instituicao(instituicao)
          qtd_perguntas  += 1
        end
      end
      
      soma_respostas / qtd_perguntas
    end

    def media_por_curso(curso)
      soma_respostas = 0
      qtd_perguntas  = 0
      
      dimensoes.each do |dimensao|
        dimensao.perguntas.each do |pergunta|
          soma_respostas += pergunta.media_por_curso(curso)
          qtd_perguntas  += 1
        end
      end
      
      soma_respostas / qtd_perguntas
    end

    def media_por_turma(turma)
      soma_respostas = 0
      qtd_perguntas  = 0
      
      dimensoes.each do |dimensao|
        dimensao.perguntas.each do |pergunta|
          soma_respostas += pergunta.media_por_turma(turma)
          qtd_perguntas  += 1
        end
      end
      
      soma_respostas / qtd_perguntas
    end
    
    def media_por_coordenador(curso)
      soma_respostas = 0
      qtd_perguntas  = 0
      
      Dimensao.coordenador.where(:pesquisa_id => id).each do |dimensao|
        dimensao.perguntas.each do |pergunta|
          soma_respostas += pergunta.media_por_coordenador(curso)
          qtd_perguntas  += 1
        end
      end
      
      soma_respostas / qtd_perguntas
    end
  end # module Estatisticas
end # module PesquisaDocente