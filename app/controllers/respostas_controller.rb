class RespostasController < ApplicationController
  before_filter :authenticate_usuario!
  
  # GET /respostas
  # GET /respostas.json
  def index
    @respostas = Resposta.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @respostas }
    end
  end

  # GET /respostas/1
  # GET /respostas/1.json
  def show
    @resposta = Resposta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resposta }
    end
  end

  # GET /respostas/new
  # GET /respostas/new.json
  def new
    @resposta = Resposta.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resposta }
    end
  end

  # GET /respostas/1/edit
  def edit
    @resposta = Resposta.find(params[:id])
  end

  # POST /respostas
  # POST /respostas.json
  def create
    @resposta = Resposta.new(params[:resposta])

    respond_to do |format|
      if @resposta.save
        format.html { redirect_to @resposta, notice: 'Resposta was successfully created.' }
        format.json { render json: @resposta, status: :created, location: @resposta }
      else
        format.html { render action: "new" }
        format.json { render json: @resposta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /respostas/1
  # PUT /respostas/1.json
  def update
    @resposta = Resposta.find(params[:id])

    respond_to do |format|
      if @resposta.update_attributes(params[:resposta])
        format.html { redirect_to @resposta, notice: 'Resposta was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resposta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /respostas/1
  # DELETE /respostas/1.json
  def destroy
    @resposta = Resposta.find(params[:id])
    @resposta.destroy

    respond_to do |format|
      format.html { redirect_to respostas_url }
      format.json { head :no_content }
    end
  end
end
