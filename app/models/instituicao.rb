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
  include PesquisaDocente::Redis
  
  has_many :cursos
  
  validates :nome, :sigla, :presence => true
  validates :sigla, :uniqueness => true
  
  def alunos_faltam_responder
    0#Aluno.where(:id => $redis.sdiff(self.redis_key(:alunos), self.redis_key(:alunos_responderam))).order(:nome)
  end
  
  def total_alunos
    0#$redis.scard(self.redis_key(:alunos))
  end

  def total_alunos_responderam
    0#$redis.scard(self.redis_key(:alunos_responderam))
  end
  
  def percentual_responderam
    100 * self.total_alunos_responderam / self.total_alunos
  end
end
