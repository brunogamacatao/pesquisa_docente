# == Schema Information
#
# Table name: instituicoes
#
#  id         :integer(4)      not null, primary key
#  nome       :string(255)
#  sigla      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Instituicao < ActiveRecord::Base
  @@total_alunos_cache       = {}
  @@total_alunos_responderam = {}
  
  has_many :cursos
  
  validates :nome, :sigla, :presence => true
  validates :sigla, :uniqueness => true
  
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
    100 * self.total_alunos_responderam / self.total_alunos
  end
  
  def calcula_total_alunos
    instituicoes  = Instituicao.arel_table
    cursos        = Curso.arel_table
    disciplinas   = Disciplina.arel_table
    turmas        = Turma.arel_table
    alunos_turmas = Arel::Table.new(:alunos_turmas)
    alunos        = Aluno.arel_table
    
    query = instituicoes                                                \
      .join(cursos).on(instituicoes[:id].eq(cursos[:instituicao_id]))   \
      .join(disciplinas).on(cursos[:id].eq(disciplinas[:curso_id]))     \
      .join(turmas).on(disciplinas[:id].eq(turmas[:disciplina_id]))     \
      .join(alunos_turmas).on(turmas[:id].eq(alunos_turmas[:turma_id])) \
      .join(alunos).on(alunos[:id].eq(alunos_turmas[:aluno_id]))        \
      .where(instituicoes[:id].eq(self.id))                             \
      .project('count(distinct alunos.id) as total')

    connection.select_one(query.to_sql)["total"]
  end
  
  def calcula_total_alunos_responderam
    instituicoes  = Instituicao.arel_table
    cursos        = Curso.arel_table
    disciplinas   = Disciplina.arel_table
    turmas        = Turma.arel_table
    alunos_turmas = Arel::Table.new(:alunos_turmas)
    alunos        = Aluno.arel_table
    respostas     = Resposta.arel_table
    
    query = instituicoes                                                \
      .join(cursos).on(instituicoes[:id].eq(cursos[:instituicao_id]))   \
      .join(disciplinas).on(cursos[:id].eq(disciplinas[:curso_id]))     \
      .join(turmas).on(disciplinas[:id].eq(turmas[:disciplina_id]))     \
      .join(alunos_turmas).on(turmas[:id].eq(alunos_turmas[:turma_id])) \
      .join(alunos).on(alunos[:id].eq(alunos_turmas[:aluno_id]))        \
      .join(respostas).on(alunos[:id].eq(respostas[:aluno_id]))         \
      .where(instituicoes[:id].eq(self.id))                             \
      .project('count(distinct alunos.id) as total')

    connection.select_one(query.to_sql)["total"]
  end
end
