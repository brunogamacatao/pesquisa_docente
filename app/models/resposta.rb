# encoding: utf-8
# == Schema Information
#
# Table name: respostas
#
#  id          :integer(4)      not null, primary key
#  nota        :integer(4)
#  pergunta_id :integer(4)
#  turma_id    :integer(4)
#  aluno_id    :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Resposta < ActiveRecord::Base
  belongs_to :pergunta
  belongs_to :aluno
  belongs_to :turma
  belongs_to :professor
  
  validates :nota, :pergunta_id, :presence => true
  validates :nota, :numericality => true
  validates_uniqueness_of :pergunta_id, :scope => [:aluno_id, :turma_id], :message => 'Você já respondeu a esta pergunta para esta turma.'
  
  # after_create :invalidate_cache
  # after_save :invalidate_cache
  
  scope :da_pesquisa, lambda { |pesquisa| joins(:pergunta => [{:dimensao => :pesquisa}]).where("pesquisas.id = ?", pesquisa.id)}
  
  # private 
  # def invalidate_cache
  #   if self.turma
  #     $redis.sadd(self.turma.redis_key(:alunos_responderam), self.aluno.id)
  #     $redis.sadd(self.turma.disciplina.curso.redis_key(:alunos_responderam), self.aluno.id)
  #     $redis.sadd(self.turma.disciplina.curso.instituicao.redis_key(:alunos_responderam), self.aluno.id)
  #   else
  #     cursos = self.aluno.turmas.group_by { |t| t.disciplina.curso }
  #     cursos.each do |c|
  #       curso = c[0]
  #       $redis.sadd(curso.redis_key(:alunos_responderam), self.aluno.id)
  #       $redis.sadd(curso.instituicao.redis_key(:alunos_responderam), self.aluno.id)
  #     end
  #   end
  # end
end
