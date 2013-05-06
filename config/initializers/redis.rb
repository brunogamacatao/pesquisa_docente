puts "Conectando-se ao servidor Redis"
$redis = Redis.new(:host => 'localhost', :port => 6379)
puts "Pronto !"