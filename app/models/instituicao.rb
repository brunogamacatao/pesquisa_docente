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
    100 * self.total_alunos_responderam / self.total_alunos
  end
  
  def redis_key(str)
    "#{self.class.to_s.downcase}:#{self.id}:#{str}"
  end  
  
  def self.gerar_relatorio_csv(instituicao_id, pesquisa_id)
    instituicao = get(instituicao_id)
    pesquisa    = Pesquisa.get(pesquisa_id)
    
    arquivo = "/tmp/#{sigla}.csv"
    arquivo = "/home/deployer/apps/pesquisa_docente/current/log/#{sigla}.csv" if Rails.env.production?
    
    CSV.open(arquivo, "wb") do |csv|
      linha         = []
      ids_perguntas = []
    
      pesquisa.dimensoes.each do |dimensao|
        dimensao.perguntas.order("ordem").each do |pergunta|
          linha << pergunta.ordem
          ids_perguntas << pergunta.id
        end # end each
      end # end each
      
      csv << linha
    
      $redis.smembers(instituicao.redis_key(:alunos_responderam)).each do |aluno_id|
        resposta = [] 
        qtd = 0
        ids_perguntas.each do |pergunta_id|
          r = Resposta.where("aluno_id = ? AND pergunta_id = ?", aluno_id, pergunta_id).first
          if r
            resposta << r.nota
            qtd += 1
          else
            resposta << '-'
          end # end if
        end # end each
        csv << resposta if qtd > 0
      end # end each
    end # end CSV
  end # end def
end
