class MatriculasController < ApplicationController

  def index
    
  end

  def nao_esta_matriculado?
    @turma = Turma.find(session[:turma_id])
      sql = "select a.nome, c.nome from matriculas m, cursos c, turmas t, alunos a
          where m.aluno_id = a.id AND m.turma_id = t.id AND t.curso_id = c.id AND
          c.id = #{@turma.curso_id} AND a.id = #{session[:aluno_id]}"
    Matricula.find_by_sql(sql).empty?
  end 

  def recarregar_turmas
    @lista = Turma.find(:all, :conditions => ["curso_id = ?", params[:curso_id]])

    render :update do |page|
      page.replace_html 'lista', :object => @lista
    end
  end
  

  def consultar
    @matricula = Matricula.find(params[:id])
  end

  def editar
    
  end

  def matricular
    @lista = Turma.find(:all)
    @matricula = Matricula.new
    @aluno = Aluno.find(params[:id])
    session[:aluno_id] = params[:id]    
  end

  def create
    @matricula = Matricula.new(params[:matricula])
    data = Time.new
    matricula = String(data.year) + String(@matricula.turma.curso_id) + String(@matricula.aluno_id)
    session[:matricula] = matricula
    respond_to do |format|
      session[:turma_id] = @matricula.turma_id      
      if nao_esta_matriculado?
        @matricula.matricula = session[:matricula]
        if @matricula.save
          format.html { redirect_to(consultar_matricula_path(@matricula), :notice => 'A matrícula foi realizada com sucesso.') }
          format.xml  { render :xml => @matricula, :status => :created, :location => @matricula }
        else
          format.html { render :action => "matricular" }
          format.xml  { render :xml => @matricula.errors, :status => :unprocessable_entity }
        end
      else
        format.html { redirect_to(matricular_aluno_path(session[:aluno_id]), :notice => 'Este aluno já está matriculado.') }
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

  def pesquisa
    @matriculas = Matricula.all
  end

end
