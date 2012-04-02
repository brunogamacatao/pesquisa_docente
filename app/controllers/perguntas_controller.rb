class PerguntasController < ApplicationController
  # GET /perguntas
  # GET /perguntas.json
  def index
    @perguntas = Pergunta.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @perguntas }
    end
  end

  # GET /perguntas/1
  # GET /perguntas/1.json
  def show
    @pergunta = Pergunta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pergunta }
    end
  end

  # GET /perguntas/new
  # GET /perguntas/new.json
  def new
    @pergunta = Pergunta.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pergunta }
    end
  end

  # GET /perguntas/1/edit
  def edit
    @pergunta = Pergunta.find(params[:id])
  end

  # POST /perguntas
  # POST /perguntas.json
  def create
    @pergunta = Pergunta.new(params[:pergunta])

    respond_to do |format|
      if @pergunta.save
        format.html { redirect_to @pergunta, notice: 'Pergunta was successfully created.' }
        format.json { render json: @pergunta, status: :created, location: @pergunta }
      else
        format.html { render action: "new" }
        format.json { render json: @pergunta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /perguntas/1
  # PUT /perguntas/1.json
  def update
    @pergunta = Pergunta.find(params[:id])

    respond_to do |format|
      if @pergunta.update_attributes(params[:pergunta])
        format.html { redirect_to @pergunta, notice: 'Pergunta was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pergunta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perguntas/1
  # DELETE /perguntas/1.json
  def destroy
    @pergunta = Pergunta.find(params[:id])
    @pergunta.destroy

    respond_to do |format|
      format.html { redirect_to perguntas_url }
      format.json { head :no_content }
    end
  end
end
