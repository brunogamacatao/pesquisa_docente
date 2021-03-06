# == Schema Information
#
# Table name: perguntas
#
#  id          :integer(4)      not null, primary key
#  pergunta    :string(255)
#  ordem       :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  dimensao_id :integer(4)
#

class Pergunta < ActiveRecord::Base
  has_many :respostas
  belongs_to :dimensao
  
  validates :pergunta, :ordem, :presence => true
  validates :ordem, :numericality => true
  
  def media_geral
    self.respostas.average(:nota)
  end
  
  def media_por_instituicao(instituicao)
    result = connection.select_one "SELECT AVG(r.nota) as media
    FROM perguntas p
    INNER JOIN respostas r ON r.pergunta_id = p.id
    INNER JOIN turmas t ON r.turma_id = t.id
    INNER JOIN disciplinas d ON t.disciplina_id = d.id
    INNER JOIN cursos c ON d.curso_id = c.id
    INNER JOIN instituicoes i ON c.instituicao_id = i.id
    WHERE p.id = #{self.id} AND i.id = #{instituicao.id}"
    result["media"] || 0
  end
  
  def media_por_curso(curso)
    result = connection.select_one "SELECT AVG(r.nota) as media
    FROM perguntas p
    INNER JOIN respostas r ON r.pergunta_id = p.id
    INNER JOIN turmas t ON r.turma_id = t.id
    INNER JOIN disciplinas d ON t.disciplina_id = d.id
    INNER JOIN cursos c ON d.curso_id = c.id
    WHERE p.id = #{self.id} AND c.id = #{curso.id}"
    result["media"] || 0
  end
  
  def media_por_coordenador(curso)
    result = connection.select_one "SELECT AVG(r.nota) as media
    FROM perguntas p
    INNER JOIN dimensoes dim ON p.dimensao_id = dim.id AND dim.tipo = 1
    INNER JOIN respostas r ON r.pergunta_id = p.id
    INNER JOIN alunos a ON r.aluno_id = a.id
    INNER JOIN alunos_turmas alt ON alt.aluno_id = a.id
    INNER JOIN turmas t ON alt.turma_id = t.id
    INNER JOIN disciplinas d ON t.disciplina_id = d.id
    INNER JOIN cursos c ON d.curso_id = c.id
    WHERE p.id = #{self.id} AND c.id = #{curso.id}"
    result["media"] || 0
  end
  
  def media_por_turma(turma)
    result = connection.select_one "SELECT AVG(r.nota) as media
    FROM perguntas p
    INNER JOIN respostas r ON r.pergunta_id = p.id
    INNER JOIN turmas t ON r.turma_id = t.id
    WHERE p.id = #{self.id} AND t.id = #{turma.id}"
    result["media"] || 0
  end
  
end
