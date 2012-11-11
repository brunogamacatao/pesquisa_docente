module PesquisaDocente
  module Redis
    def redis_key(str)
      "#{self.class.to_s.downcase}:#{self.id}:#{str}"
    end  
  end
end