class DisciplinasController < ApplicationController
  # GET /disciplinas
  # GET /disciplinas.json
  def index
    @disciplinas = Disciplina.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @disciplinas }
    end
  end

  # GET /disciplinas/1
  # GET /disciplinas/1.json
  def show
    @disciplina = Disciplina.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @disciplina }
    end
  end

  # GET /disciplinas/new
  # GET /disciplinas/new.json
  def new
    @disciplina = Disciplina.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @disciplina }
    end
  end

  # GET /disciplinas/1/edit
  def edit
    @disciplina = Disciplina.find(params[:id])
  end

  # POST /disciplinas
  # POST /disciplinas.json
  def create
    @disciplina = Disciplina.new(params[:disciplina])

    respond_to do |format|
      if @disciplina.save
        format.html { redirect_to @disciplina, notice: 'Disciplina was successfully created.' }
        format.json { render json: @disciplina, status: :created, location: @disciplina }
      else
        format.html { render action: "new" }
        format.json { render json: @disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /disciplinas/1
  # PUT /disciplinas/1.json
  def update
    @disciplina = Disciplina.find(params[:id])

    respond_to do |format|
      if @disciplina.update_attributes(params[:disciplina])
        format.html { redirect_to @disciplina, notice: 'Disciplina was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @disciplina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplinas/1
  # DELETE /disciplinas/1.json
  def destroy
    @disciplina = Disciplina.find(params[:id])
    @disciplina.destroy

    respond_to do |format|
      format.html { redirect_to disciplinas_url }
      format.json { head :no_content }
    end
  end
end
