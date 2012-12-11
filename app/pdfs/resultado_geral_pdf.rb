# -*- coding: utf-8 -*- 
class ResultadoGeralPdf < Prawn::Document
  def initialize(pesquisa, dimensoes, total_respostas, total_alunos, view)
    super(top_margin: 70)
    @pesquisa        = pesquisa
    @dimensoes       = dimensoes
    @total_respostas = total_respostas
    @total_alunos    = total_alunos
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
    items = []
    
    @dimensoes.each do |dimensao|
      its = dimensao.perguntas.map do |pergunta|
        [
          pergunta.ordem,
          pergunta.pergunta,
          formata_numero(pergunta.media_geral)
        ]
      end
      
      items += its
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
    qtd = 0
    @dimensoes.each do |dimensao|
      dimensao.perguntas.each do |pergunta| 
        nota_total += pergunta.media_geral
        qtd += 1
      end
    end
    media_geral = nota_total / qtd
    
    text "Total de alunos que responderam: #{@total_respostas} (de um total de #{@total_alunos}) (#{@view.number_to_percentage 100 * @total_respostas / @total_alunos, :precision => 0})", :size => 12, :style => :bold, :align => :center
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