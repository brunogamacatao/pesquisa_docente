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
  include PesquisaDocente::Redis
  
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
  
  def alunos_faltam_responder
    Aluno.where(:id => $redis.sdiff(self.redis_key(:alunos), self.redis_key(:alunos_responderam))).order(:nome)
  end
  
  def total_alunos
    $redis.scard(self.redis_key(:alunos))
  end

  def total_alunos_responderam
    $redis.scard(self.redis_key(:alunos_responderam))
  end
  
  def percentual_responderam
    (self.total_alunos != 0 && 100 * self.total_alunos_responderam / self.total_alunos) || 0
  end
end
