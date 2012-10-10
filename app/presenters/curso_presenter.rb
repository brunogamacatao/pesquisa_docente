# -*- coding: utf-8 -*- 
class CursoPresenter < BasePresenter
  presents :curso
  
  def link_alunos_que_nao_responderam
    h.link_to 'Alunos que faltam responder', 
      {:action => :alunos_que_faltam_por_curso}, 
      :id => curso.id, 
      :class => "btn btn-warning"
  end
  
  def barra_de_percentual
    h.barra_de_progresso(curso.percentual_responderam)
  end
  
  def barra_percentual_pergunta(pergunta)
    barra_progresso_nota(pergunta.media_por_curso(curso))
  end
  
  def barra_media_geral(pesquisa)
    barra_progresso_nota(pesquisa.media_por_curso(curso))
  end
  
  def link_resultado_por_turma(turma)
    h.link_to "#{turma.professor.nome} - #{turma.disciplina.nome} #{turma.turno} #{turma.horario} (#{turma.total_alunos_responderam} de #{turma.total_alunos})", 
      :action => 'resultado_por_turma', 
      :id => turma.id
  end
  
  def botao_imprimir
    h.link_to 'Imprimir', 
      {:action => :resultado_por_curso, :id => curso.id, :format => :pdf}, 
      :class => "btn btn-success"
  end
  
  def botao_excel
    h.link_to 'Excel', 
      {:action => :resultado_por_curso, :id => curso.id, :format => :csv}, 
      :class => "btn btn-success"
  end
end