class Eleicao::ChapasController < ApplicationController
  before_filter :authenticate_usuario!
  
  # GET /eleicao/chapas
  # GET /eleicao/chapas.json
  def index
    @eleicao_chapas = Eleicao::Chapa.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @eleicao_chapas }
    end
  end

  # GET /eleicao/chapas/1
  # GET /eleicao/chapas/1.json
  def show
    @eleicao_chapa = Eleicao::Chapa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @eleicao_chapa }
    end
  end

  # GET /eleicao/chapas/new
  # GET /eleicao/chapas/new.json
  def new
    @eleicao_chapa = Eleicao::Chapa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @eleicao_chapa }
    end
  end

  # GET /eleicao/chapas/1/edit
  def edit
    @eleicao_chapa = Eleicao::Chapa.find(params[:id])
  end

  # POST /eleicao/chapas
  # POST /eleicao/chapas.json
  def create
    @eleicao_chapa = Eleicao::Chapa.new(params[:eleicao_chapa])

    respond_to do |format|
      if @eleicao_chapa.save
        format.html { redirect_to @eleicao_chapa, notice: 'Chapa was successfully created.' }
        format.json { render json: @eleicao_chapa, status: :created, location: @eleicao_chapa }
      else
        format.html { render action: "new" }
        format.json { render json: @eleicao_chapa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /eleicao/chapas/1
  # PUT /eleicao/chapas/1.json
  def update
    @eleicao_chapa = Eleicao::Chapa.find(params[:id])

    respond_to do |format|
      if @eleicao_chapa.update_attributes(params[:eleicao_chapa])
        format.html { redirect_to @eleicao_chapa, notice: 'Chapa was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @eleicao_chapa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eleicao/chapas/1
  # DELETE /eleicao/chapas/1.json
  def destroy
    @eleicao_chapa = Eleicao::Chapa.find(params[:id])
    @eleicao_chapa.destroy

    respond_to do |format|
      format.html { redirect_to eleicao_chapas_url }
      format.json { head :no_content }
    end
  end
end