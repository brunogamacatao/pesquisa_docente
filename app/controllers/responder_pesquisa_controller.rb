class ResponderPesquisaController < ApplicationController
  def responder_pesquisa
    @pesquisa = Pesquisa.find(params[:id])
  end
  
  def iniciar_respostas
    @pesquisa = Pesquisa.find(params[:id])
    @aluno    = Aluno.find(:first, :conditions => {:matricula => params[:matricula]})
    
    turmas = @aluno.turmas
    
    @aluno.respostas.each do |resposta|
      turmas.delete(resposta.turma)
    end
    
    unless turmas.empty?
      @turma = turmas[0]
    else
      render :action => 'pesquisa_finalizada'
    end
  end
  
  def pesquisa_finalizada
  end
  
  def enviar_respostas
    params[:respostas].each do |k, resposta|
      Resposta.create(resposta)
    end
    redirect_to :action => 'iniciar_respostas', :id => params[:id], :matricula => params[:matricula]
  end
end
