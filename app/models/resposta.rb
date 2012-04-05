# encoding: utf-8
class Resposta < ActiveRecord::Base
  belongs_to :pergunta
  belongs_to :aluno
  belongs_to :turma
  
  validates :nota, :aluno_id, :turma_id, :pergunta_id, :presence => true
  validates :nota, :numericality => true
  validates_uniqueness_of :pergunta_id, :scope => [:aluno_id, :turma_id], :message => 'Você já respondeu a esta pergunta para esta turma.'
  
  after_create { |resposta| resposta.turma.disciplina.curso.invalidate_cache }
  after_save   { |resposta| resposta.turma.disciplina.curso.invalidate_cache }
end
