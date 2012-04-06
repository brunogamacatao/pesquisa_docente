class PesquisasController < ApplicationController
  before_filter :authenticate_usuario!
  
  # GET /pesquisas
  # GET /pesquisas.json
  def index
    @pesquisas = Pesquisa.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pesquisas }
    end
  end

  # GET /pesquisas/1
  # GET /pesquisas/1.json
  def show
    @pesquisa = Pesquisa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pesquisa }
    end
  end

  # GET /pesquisas/new
  # GET /pesquisas/new.json
  def new
    @pesquisa = Pesquisa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pesquisa }
    end
  end

  # GET /pesquisas/1/edit
  def edit
    @pesquisa = Pesquisa.find(params[:id])
  end

  # POST /pesquisas
  # POST /pesquisas.json
  def create
    @pesquisa = Pesquisa.new(params[:pesquisa])

    respond_to do |format|
      if @pesquisa.save
        format.html { redirect_to @pesquisa, notice: 'Pesquisa was successfully created.' }
        format.json { render json: @pesquisa, status: :created, location: @pesquisa }
      else
        format.html { render action: "new" }
        format.json { render json: @pesquisa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pesquisas/1
  # PUT /pesquisas/1.json
  def update
    @pesquisa = Pesquisa.find(params[:id])

    respond_to do |format|
      if @pesquisa.update_attributes(params[:pesquisa])
        format.html { redirect_to @pesquisa, notice: 'Pesquisa was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pesquisa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pesquisas/1
  # DELETE /pesquisas/1.json
  def destroy
    @pesquisa = Pesquisa.find(params[:id])
    @pesquisa.destroy

    respond_to do |format|
      format.html { redirect_to pesquisas_url }
      format.json { head :no_content }
    end
  end
end
