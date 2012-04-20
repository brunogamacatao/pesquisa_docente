class InstituicaoPresenter < BasePresenter
  presents :instituicao
  
  def barra_de_percentual
    h.barra_de_progresso(instituicao.percentual_responderam)
  end
  
  def barra_percentual_pergunta(pergunta)
    barra_progresso_nota(pergunta.media_por_instituicao(instituicao))
  end
  
  def link_alunos_que_nao_responderam
    h.link_to 'Alunos que faltam responder', 
      {:action => :alunos_que_faltam_por_instituicao}, 
      :id => instituicao.id, 
      :class => "btn btn-warning"
  end
  
  def barra_media_geral(pesquisa)
    barra_progresso_nota(pesquisa.media_por_instituicao(instituicao))
  end
  
  def link_resultado_por_curso(curso)
      h.link_to "#{curso.nome} (#{curso.total_alunos_responderam} de #{curso.total_alunos})", 
        :action => "resultado_por_curso", 
        :id => curso.id
  end
  
  def botao_imprimir
    h.link_to 'Imprimir', 
      {:action => :resultado_por_instituicao, :id => instituicao.id, :format => :pdf}, 
      :class => "btn btn-success"
  end
end