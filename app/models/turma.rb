# == Schema Information
#
# Table name: turmas
#
#  id            :integer(4)      not null, primary key
#  turno         :string(255)
#  horario       :string(255)
#  professor_id  :integer(4)
#  disciplina_id :integer(4)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Turma < ActiveRecord::Base
  has_and_belongs_to_many :alunos
  belongs_to :professor
  belongs_to :disciplina
  
  validates :turno, :horario, :presence => true
  
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
  
  def redis_key(str)
    "#{self.class.to_s.downcase}:#{self.id}:#{str}"
  end  
end
