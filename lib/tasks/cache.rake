namespace :pesquisa do
  desc "Constroi a cache do Redis"
  task :build_cache => :environment do
    
    puts "Construindo a cache"
    
    pesquisa = Pesquisa.ativa.first
    
    $redis.multi do
      total_de_turmas = Turma.all.count()
      turma_atual = 1
      
      Turma.all.each do |turma|
        puts "Processando a turma #{turma_atual} de #{total_de_turmas} ..."
        
        turma.alunos.each do |aluno|
          $redis.sadd(turma.redis_key(:alunos), aluno.id)
          $redis.sadd(turma.disciplina.curso.redis_key(:alunos), aluno.id)
          $redis.sadd(turma.disciplina.curso.instituicao.redis_key(:alunos), aluno.id)
      
          unless Resposta.da_pesquisa(pesquisa).where("aluno_id = ?", aluno.id).empty?
            $redis.sadd(turma.redis_key(:alunos_responderam), aluno.id)
            $redis.sadd(turma.disciplina.curso.redis_key(:alunos_responderam), aluno.id)
            $redis.sadd(turma.disciplina.curso.instituicao.redis_key(:alunos_responderam), aluno.id)
          end
        end
        
        turma_atual += 1
      end
    end
    
    puts "Pronto !"    
  end
end