class PesquisaPresenter < BasePresenter
  presents :pesquisa
  
  def barra_de_percentual
    h.barra_de_progresso(percentual)
  end
  
  def barra_percentual_pergunta(pergunta)
    h.barra_de_progresso(pergunta.media_geral * 10, pergunta.media_geral)
  end
  
  def barra_media_geral
    h.barra_de_progresso(pesquisa.media_geral * 10, pesquisa.media_geral)
  end
  
  def link_resultado_instituicao(instituicao)
    h.link_to "#{instituicao.sigla} (#{instituicao.total_alunos_responderam} de #{instituicao.total_alunos})", :action => 'resultado_por_instituicao', :id => instituicao.id
  end
  
  def barra_media_instituicao(instituicao)
    h.barra_de_progresso(instituicao.percentual_responderam)
  end
  
private  
  def percentual
    instituicoes    = Instituicao.order(:nome)
    total_alunos    = 0
    total_respostas = 0

    instituicoes.each do |instituicao|
      total_alunos    += instituicao.total_alunos
      total_respostas += instituicao.total_alunos_responderam
    end

    (total_alunos > 0 && (total_respostas / total_alunos)) || 0
  end
end