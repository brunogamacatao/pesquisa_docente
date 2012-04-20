# -*- coding: utf-8 -*- 
class ResultadoInstituicaoPdf < Prawn::Document
  def initialize(pesquisa, perguntas, instituicao, view)
    super(top_margin: 70)
    @pesquisa        = pesquisa
    @perguntas       = perguntas
    @instituicao     = instituicao
    @view            = view
    
    cabecalho
    tabela
    resumo
    rodape
  end
  
  def cabecalho
    text "#{@pesquisa.nome}", :size => 20, :style => :bold, :align => :center
    move_down 30
  end
  
  def tabela
    items = @perguntas.map do |pergunta|
      [
        pergunta.ordem,
        pergunta.pergunta,
        formata_numero(pergunta.media_por_instituicao(@instituicao))
      ]
    end
    
    doc_width = bounds.width

    table [["", "Desempenho Docente em Sala de Aula", "Média"]] + items do 
      row(0).font_style = :bold
      columns(0).align = :center
      columns(2).align = :center
      self.header = true
      self.width = doc_width
    end

    move_down 30
  end
  
  def resumo
    nota_total = 0
    @perguntas.each  { |pergunta| nota_total += pergunta.media_por_instituicao(@instituicao) }
    media_geral = nota_total / @perguntas.count
    
    text "Total de alunos que responderam: #{@instituicao.total_alunos_responderam} (de um total de #{@instituicao.total_alunos}) (#{@view.number_to_percentage @instituicao.total_alunos_responderam / @instituicao.total_alunos, :precision => 0})", :size => 12, :style => :bold, :align => :center
    text "Média Geral -> #{formata_numero media_geral}", :size => 12, :style => :bold, :align => :center
    move_down 10
  end
  
  def rodape
    text "© Laboratório de Tecnologia da Informação 2012", :size => 10, :align => :center
  end
  
private
  def formata_numero(n)
    @view.number_with_precision(n, :precision => 1, :separator => ',', :delimiter => '.')
  end
end