# == Schema Information
#
# Table name: cursos
#
#  id             :integer(4)      not null, primary key
#  nome           :string(255)
#  instituicao_id :integer(4)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

require 'set'

class Curso < ActiveRecord::Base
  @@total_alunos_cache       = {}
  @@total_alunos_responderam = {}

  belongs_to :instituicao
  has_many :disciplinas
  
  validates :nome, :presence => true
  validates :nome, :uniqueness => true
  
  def turmas
    turmas = Set.new
    self.disciplinas.each do |disciplina|
      turmas.merge(disciplina.turmas)
    end
    turmas
  end
  
  def self.invalidate_cache(id)
    @@total_alunos_cache.delete(id)
    @@total_alunos_responderam.delete(id)
  end

  def total_alunos
    @@total_alunos_cache[self.id] ||= self.calcula_total_alunos()
  end

  def total_alunos_responderam
    @@total_alunos_responderam[self.id] ||= self.calcula_total_alunos_responderam()
  end
  
  def percentual_responderam
    (self.total_alunos != 0 && 100 * self.total_alunos_responderam / self.total_alunos) || 0
  end
  
  def calcula_total_alunos
    result = connection.select_one "SELECT COUNT(*) AS total FROM
    (SELECT DISTINCT a.id 
    FROM cursos c 
    INNER JOIN disciplinas d ON d.curso_id = c.id 
    INNER JOIN turmas t ON t.disciplina_id = d.id 
    INNER JOIN alunos_turmas at ON at.turma_id = t.id 
    INNER JOIN alunos a ON at.aluno_id = a.id
    WHERE c.id = #{self.id}) t"
    result["total"]
  end
  
  def calcula_total_alunos_responderam
    result = connection.select_one "SELECT COUNT(*) AS total FROM
    (SELECT DISTINCT a.id 
    FROM cursos c 
    INNER JOIN disciplinas d ON d.curso_id = c.id 
    INNER JOIN turmas t ON t.disciplina_id = d.id 
    INNER JOIN alunos_turmas at ON at.turma_id = t.id 
    INNER JOIN alunos a ON at.aluno_id = a.id
    INNER JOIN respostas r ON r.aluno_id = a.id
    WHERE c.id = #{self.id}) t"
    result["total"]
  end
end
