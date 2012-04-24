class CoordenadoresController < ApplicationController
  before_filter :authenticate_usuario!

  # GET /coordenadores
  # GET /coordenadores.json
  def index
    authorize! :admin, Coordenador
    
    @coordenadores = Coordenador.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coordenadores }
    end
  end

  # GET /coordenadores/1
  # GET /coordenadores/1.json
  def show
    authorize! :admin, Coordenador
    
    @coordenador = Coordenador.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coordenador }
    end
  end

  # GET /coordenadores/new
  # GET /coordenadores/new.json
  def new
    authorize! :admin, Coordenador
    
    @coordenador = Coordenador.new
    @coordenador.build_usuario

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coordenador }
    end
  end

  # GET /coordenadores/1/edit
  def edit
    authorize! :admin, Coordenador
    
    @coordenador = Coordenador.find(params[:id])
  end

  # POST /coordenadores
  # POST /coordenadores.json
  def create
    authorize! :admin, Coordenador
    
    @coordenador = Coordenador.new(params[:coordenador])

    respond_to do |format|
      if @coordenador.save
        format.html { redirect_to @coordenador, notice: 'Coordenador was successfully created.' }
        format.json { render json: @coordenador, status: :created, location: @coordenador }
      else
        format.html { render action: "new" }
        format.json { render json: @coordenador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coordenadores/1
  # PUT /coordenadores/1.json
  def update
    authorize! :admin, Coordenador
    
    @coordenador = Coordenador.find(params[:id])

    respond_to do |format|
      if @coordenador.update_attributes(params[:coordenador])
        format.html { redirect_to @coordenador, notice: 'Coordenador was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coordenador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coordenadores/1
  # DELETE /coordenadores/1.json
  def destroy
    authorize! :admin, Coordenador
    
    @coordenador = Coordenador.find(params[:id])
    @coordenador.destroy

    respond_to do |format|
      format.html { redirect_to coordenadores_url }
      format.json { head :no_content }
    end
  end
end
