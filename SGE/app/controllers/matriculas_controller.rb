class MatriculasController < ApplicationController

  def consultar
    @matricula = Matricula.find(params[:id])
  end

  def editar
    
  end

  def matricular
    @matricula = Matricula.new
    @aluno = Aluno.find(params[:id])
    @matricula.aluno_id = @aluno.id
  end

  def create
    @matricula = Matricula.new(params[:matricula])

    respond_to do |format|
      data = DateTime.new
      @matricula.matricula = data.year + '' + @matricula.turma.curso_id + '' + @matricula.aluno_id
      if @matricula.save
        format.html { redirect_to(consultar_matricula_path(@matricula), :notice => 'A matrícula foi realizada com sucesso.') }
        format.xml  { render :xml => @matricula, :status => :created, :location => @matricula }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @matricula.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @matricula = Matricula.find(params[:id])

    respond_to do |format|
      if @matricula.update_attributes(params[:matricula])
        format.html { redirect_to(consultar_curso_path(@matricula), :notice => 'A matrícula foi alterada com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "editar" }
        format.xml  { render :xml => @matricula.errors, :status => :unprocessable_entity }
      end
    end
  end

end
