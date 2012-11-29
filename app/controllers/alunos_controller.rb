class AlunosController < ApplicationController
  # GET /alunos
  # GET /alunos.json
  def index
    @alunos = Aluno.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alunos }
    end
  end

  # GET /alunos/1
  # GET /alunos/1.json
  def show
    @aluno = Aluno.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aluno }
    end
  end

  # GET /alunos/new
  # GET /alunos/new.json
  def new
    @aluno = Aluno.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aluno }
    end
  end

  # GET /alunos/1/edit
  def edit
    @aluno = Aluno.find(params[:id])
  end

  # POST /alunos
  # POST /alunos.json
  def create
    @aluno = Aluno.new(params[:aluno])

    respond_to do |format|
      if @aluno.save
        format.html { redirect_to @aluno, notice: 'Aluno was successfully created.' }
        format.json { render json: @aluno, status: :created, location: @aluno }
      else
        format.html { render action: "new" }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /alunos/1
  # PUT /alunos/1.json
  def update
    @aluno = Aluno.find(params[:id])

    respond_to do |format|
      if @aluno.update_attributes(params[:aluno])
        format.html { redirect_to @aluno, notice: 'Aluno was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alunos/1
  # DELETE /alunos/1.json
  def destroy
    @aluno = Aluno.find(params[:id])
    @aluno.destroy

    respond_to do |format|
      format.html { redirect_to alunos_url }
      format.json { head :no_content }
    end
  end
  
  def get_aluno
    @aluno = Aluno.where("matricula like ?", "#{params[:id]}%").first
    
    respond_to do |format|
      format.json { render json: [@aluno, get_curso(@aluno)] }
    end
  end
  
  def pode_votar
    aluno   = Aluno.where("matricula like ?", "#{params[:id]}%").first
    eleicao = Eleicao::Eleicao.find(params[:eleicao_id])
    pode    = get_curso(aluno) == eleicao.curso && !Eleicao::Voto.where(aluno_id:aluno).exists?
    
    respond_to do |format|
      format.json { render json: {pode: pode}}
    end
  end
  
  private 
  def get_curso(aluno)
    cursos = {}
    
    aluno.turmas.each do |turma|
      cursos[turma.disciplina.curso] ||= 0
      cursos[turma.disciplina.curso] += 1
    end
    
    cursos = cursos.sort_by { |curso_id, qtd| qtd }
    curso  = nil
    curso  = cursos[0][0] if cursos && cursos[0] && cursos[0][0]
    
    return curso
  end
end
