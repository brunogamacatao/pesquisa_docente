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
  def redis_key(str)
    "#{self.class.to_s.downcase}:#{self.id}:#{str}"
  end  

  def self.gerar_relatorio_csv(curso_id, pesquisa_id)
    curso    = get(curso_id)
    pesquisa = Pesquisa.get(pesquisa_id)
    
    arquivo = "/tmp/#{nome}.csv"
    arquivo = "/home/deployer/apps/pesquisa_docente/current/log/#{nome}.csv" if Rails.env.production?
    
    CSV.open(arquivo, "wb") do |csv|
      linha         = []
      ids_perguntas = []
    
      pesquisa.dimensoes.each do |dimensao|
        dimensao.perguntas.order("ordem").each do |pergunta|
          linha << pergunta.ordem
          ids_perguntas << pergunta.id
        end
      end
      csv << linha
    
      $redis.smembers(curso.redis_key(:alunos_responderam)).each do |aluno_id|
        resposta = [] 
        qtd = 0
        ids_perguntas.each do |pergunta_id|
          r = Resposta.where("aluno_id = ? AND pergunta_id = ?", aluno_id, pergunta_id).first
          if r
            resposta << r.nota
            qtd += 1
          else
            resposta << '-'
          end
        end
        csv << resposta if qtd > 0
      end # end each
    end # end CSV
  end  
end
