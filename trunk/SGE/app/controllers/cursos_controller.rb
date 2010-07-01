class CursosController < ApplicationController
  before_filter :limpar_sessao, :only => [:index]
  before_filter :guarda_pesquisa_curso, :only => [:pesquisar]
  before_filter :guarda_consulta_curso, :only => [:consultar]
  
  # GET /cursos
  # GET /cursos.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cursos }
    end
  end

  # GET /cursos/1
  # GET /cursos/1.xml
  def consultar
    @curso = Curso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @curso }
    end
  end

  # GET /cursos/new
  # GET /cursos/new.xml
  def novo
    @curso = Curso.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @curso }
    end
  end

  # GET /cursos/1/edit
  def editar
    @curso = Curso.find(params[:id])
  end

  # POST /cursos
  # POST /cursos.xml
  def create
    @curso = Curso.new(params[:curso])

    respond_to do |format|
      if @curso.save
        format.html { redirect_to(consultar_curso_path(@curso), :notice => 'O curso foi criado com sucesso.') }
        format.xml  { render :xml => @curso, :status => :created, :location => @curso }
      else
        format.html { render :action => "novo" }
        format.xml  { render :xml => @curso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cursos/1
  # PUT /cursos/1.xml
  def update
    @curso = Curso.find(params[:id])

    respond_to do |format|
      if @curso.update_attributes(params[:curso])
        format.html { redirect_to(consultar_curso_path(@curso), :notice => 'O curso foi alterado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "editar" }
        format.xml  { render :xml => @curso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cursos/1
  # DELETE /cursos/1.xml
  def destroy
    @curso = Curso.find(params[:id])
    @curso.destroy

    respond_to do |format|
      format.html { redirect_to(cursos_url) }
      format.xml  { head :ok }
    end
  end

  def pesquisar
    if !params[:nome].nil? or !params[:descricao].nil? or !params[:ementa].nil?
      conditions = [""]
      sql = ""
      if !params[:nome].empty?
        sql = sql + "(UPPER(nome) LIKE UPPER(?)) AND "
        conditions <<  "%#{params[:nome]}%"
      end
      if !params[:descricao].empty?
        sql = sql + "(UPPER(descricao) LIKE UPPER(?)) AND "
        conditions << "%#{params[:descricao]}%"
      end
      if !params[:ementa].empty?
        sql = sql + "(UPPER(ementa) LIKE UPPER(?)) AND "
        conditions << "%#{params[:ementa]}%"
      end
      conditions[0] = sql[0..sql.length-5]
      @cursos = Curso.find(:all, :conditions => conditions)
      if @cursos.empty?
        redirect_to(cursos_path, :notice => 'Nenhum resultado encontrado.')
      else
        session[:cursos] = @cursos
      end
    else
      @cursos = session[:cursos]
    end
  end
end
