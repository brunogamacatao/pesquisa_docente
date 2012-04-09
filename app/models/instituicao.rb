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
  has_many :cursos
  
  validates :nome, :sigla, :presence => true
  validates :sigla, :uniqueness => true
  
  def total_alunos
    $redis.scard(self.redis_key(:alunos))
  end

  def total_alunos_responderam
    $redis.scard(self.redis_key(:alunos_responderam))
  end
  
  def percentual_responderam
    100 * self.total_alunos_responderam / self.total_alunos
  end
  
  def redis_key(str)
    "#{self.class.to_s.downcase}:#{self.id}:#{str}"
  end  
end
