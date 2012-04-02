class InstituicoesController < ApplicationController
  # GET /instituicoes
  # GET /instituicoes.json
  def index
    @instituicoes = Instituicao.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @instituicoes }
    end
  end

  # GET /instituicoes/1
  # GET /instituicoes/1.json
  def show
    @instituicao = Instituicao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @instituicao }
    end
  end

  # GET /instituicoes/new
  # GET /instituicoes/new.json
  def new
    @instituicao = Instituicao.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @instituicao }
    end
  end

  # GET /instituicoes/1/edit
  def edit
    @instituicao = Instituicao.find(params[:id])
  end

  # POST /instituicoes
  # POST /instituicoes.json
  def create
    @instituicao = Instituicao.new(params[:instituicao])

    respond_to do |format|
      if @instituicao.save
        format.html { redirect_to @instituicao, notice: 'Instituicao was successfully created.' }
        format.json { render json: @instituicao, status: :created, location: @instituicao }
      else
        format.html { render action: "new" }
        format.json { render json: @instituicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /instituicoes/1
  # PUT /instituicoes/1.json
  def update
    @instituicao = Instituicao.find(params[:id])

    respond_to do |format|
      if @instituicao.update_attributes(params[:instituicao])
        format.html { redirect_to @instituicao, notice: 'Instituicao was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @instituicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instituicoes/1
  # DELETE /instituicoes/1.json
  def destroy
    @instituicao = Instituicao.find(params[:id])
    @instituicao.destroy

    respond_to do |format|
      format.html { redirect_to instituicoes_url }
      format.json { head :no_content }
    end
  end
end
