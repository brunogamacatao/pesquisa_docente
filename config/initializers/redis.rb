$redis = Redis.new(:host => 'localhost', :port => 6379)

puts "Construindo a cache"

turma = Turma.first
#if $redis.scard(turma.redis_key(:alunos)) == 0

if !Rails.env.test?
  $redis.multi do
    Turma.all.each do |turma|
      turma.alunos.each do |aluno|
        $redis.sadd(turma.redis_key(:alunos), aluno.id)
        $redis.sadd(turma.disciplina.curso.redis_key(:alunos), aluno.id)
        $redis.sadd(turma.disciplina.curso.instituicao.redis_key(:alunos), aluno.id)
    
        unless aluno.respostas.empty? 
          $redis.sadd(turma.redis_key(:alunos_responderam), aluno.id)
          $redis.sadd(turma.disciplina.curso.redis_key(:alunos_responderam), aluno.id)
          $redis.sadd(turma.disciplina.curso.instituicao.redis_key(:alunos_responderam), aluno.id)
        end
      end
    end
  end
end

# else
#   puts "A cache ja estava criada"
# end

puts "Pronto !"