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
  
  validates :nota, :aluno_id, :turma_id, :pergunta_id, :presence => true
  validates :nota, :numericality => true
  validates_uniqueness_of :pergunta_id, :scope => [:aluno_id, :turma_id], :message => 'Você já respondeu a esta pergunta para esta turma.'
  
  after_create do |resposta| 
    Instituicao.invalidate_cache(resposta.turma.disciplina.curso.instituicao.id)
    Curso.invalidate_cache(resposta.turma.disciplina.curso.id)
    Turma.invalidate_cache(resposta.turma.id)
  end
  
  after_save do |resposta| 
    Instituicao.invalidate_cache(resposta.turma.disciplina.curso.instituicao.id)
    Curso.invalidate_cache(resposta.turma.disciplina.curso.id)
    Turma.invalidate_cache(resposta.turma.id)
  end
end
