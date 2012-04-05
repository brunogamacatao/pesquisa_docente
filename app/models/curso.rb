require 'set'

class Curso < ActiveRecord::Base
  @@cache_total_alunos = {}
  @@cache_total_alunos_responderam = {}
  
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
  
  def alunos
    alunos = Set.new
    self.disciplinas.each do |disciplina|
      disciplina.turmas.each do |turma|
        alunos.merge(turma.alunos)
      end
    end
    alunos
  end
  
  def total_alunos
    unless @@cache_total_alunos[self.id]
      @@cache_total_alunos[self.id] = self.alunos.count
    end
    @@cache_total_alunos[self.id]
  end
  
  def total_alunos_responderam
    unless @@cache_total_alunos_responderam[self.id]
      total = 0
      self.alunos.each do |aluno|
        total += 1 unless aluno.respostas.empty?
      end
      @@cache_total_alunos_responderam[self.id] = total
    end
    @@cache_total_alunos_responderam[self.id]
  end
  
  def percentual_responderam
    (self.total_alunos != 0 && self.total_alunos_responderam / self.total_alunos) || 0
  end
  
  def invalidate_cache
    @@cache_total_alunos[self.id] = nil
    @@cache_total_alunos_responderam[self.id] = nil
  end
end
