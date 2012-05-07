# encoding: utf-8
class Eleicao::EleicaoController < ApplicationController
  def index
  end
  
  def escolher_chapa
    @aluno = Aluno.find(:first, :conditions => {:matricula => params[:matricula]})
    
    unless @aluno
      flash[:erro] = "Não foi encontrado um aluno com a matrícula #{params[:matricula]}."
      redirect_to :action => "index"
      return 
    end
    
    if Eleicao::Voto.find_by_aluno_id(@aluno.id)
      flash[:erro] = "Você já votou nesta eleição !"
      redirect_to :action => "index"
      return 
    end
    
    @chapas = Eleicao::Chapa.order(:nome)
  end

  def confirmar
    aluno = Aluno.find(params[:aluno_id])
    chapa = Eleicao::Chapa.find(params[:chapa_id])
    
    Eleicao::Voto.create(aluno: aluno, chapa: chapa)
    
    flash[:sucesso] = "Seu voto foi confirmado com sucesso. Obrigado !"
    redirect_to :action => "index"
  end
end