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
    aluno = nil
    if params[:aluno_id]
      aluno = Aluno.find(params[:aluno_id])
    elsif params[:matricula]
      aluno = Aluno.where("matricula like ?", "#{params[:matricula]}%").first
    end
    
    if Eleicao::Voto.where("aluno_id = ?", aluno).exists?
      respond_to do |format|
        format.json { render json: {erro: true, mensagem: "Você já votou antes !"} }
      end
    else
      chapa_id = params[:chapa_id].to_i
      
      if chapa_id < 0
        eleicao = Eleicao::Eleicao.first
        if chapa_id == -1
          eleicao.brancos += 1
        else
          eleicao.nulos += 1
        end
        eleicao.save()
      else
        chapa = Eleicao::Chapa.find(params[:chapa_id])
        Eleicao::Voto.create(aluno: aluno, chapa: chapa)
      end
    
      respond_to do |format|
        # format.html do
        #   flash[:sucesso] = "Seu voto foi confirmado com sucesso. Obrigado !"
        #   redirect_to :action => "index"
        # end
        format.json { render json: {erro: false, mensagem: "Seu voto foi confirmado com sucesso."} }
      end
    end
  end
  
  def list
    @eleicoes = Eleicao::Eleicao.find(:all)
    
    respond_to do |format|
      format.json { render json: @eleicoes}
    end
  end
end