class DisciplinasController < ApplicationController
  before_filter :limpar_sessao, :only => [:index]
  before_filter :guarda_pesquisa_disciplina, :only => [:pesquisar]
  before_filter :guarda_consulta_disciplina, :only => [:consultar]

  # GET /disciplinas
  # GET /disciplinas.xml
  def index
    @disciplinas = Disciplina.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @disciplinas }
    end
  end

  # GET /disciplinas/1
  # GET /disciplinas/1.xml
  def consultar
    @disciplina = Disciplina.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @disciplina }
    end
  end

  # GET /disciplinas/new
  # GET /disciplinas/new.xml
  def novo
    @disciplina = Disciplina.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @disciplina }
    end
  end

  # GET /disciplinas/1/edit
  def editar
    @disciplina = Disciplina.find(params[:id])
  end

  # POST /disciplinas
  # POST /disciplinas.xml
  def create
    @disciplina = Disciplina.new(params[:disciplina])

    respond_to do |format|
      if @disciplina.save
        format.html { redirect_to(consultar_disciplina_path(@disciplina),
                                 :notice => 'Disciplina was successfully created.') }
        format.xml  { render :xml => @disciplina, :status => :created, :location => @disciplina }
      else
        format.html { render :action => "novo" }
        format.xml  { render :xml => @disciplina.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /disciplinas/1
  # PUT /disciplinas/1.xml
  def update
    @disciplina = Disciplina.find(params[:id])

    respond_to do |format|
      if @disciplina.update_attributes(params[:disciplina])
        format.html { redirect_to(consultar_disciplina_path(@disciplina),
                                  :notice => 'Disciplina was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "editar" }
        format.xml  { render :xml => @disciplina.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplinas/1
  # DELETE /disciplinas/1.xml
  def destroy
    @disciplina = Disciplina.find(params[:id])
    @disciplina.destroy

    respond_to do |format|
      format.html { redirect_to(disciplinas_url) }
      format.xml  { head :ok }
    end
  end

  def pesquisar
    if !params[:nome].nil? or !params[:curso_id].nil?
      conditions = [""]
      sql = ""
      if !params[:nome].empty?
        sql = sql + "(UPPER(nome) LIKE UPPER(?)) AND "
        conditions <<  "%#{params[:nome]}%"
      end
      if !params[:curso_id].empty?
        sql = sql + "curso_id = ? AND "
        conditions <<  "#{params[:curso_id]}"
      end
      conditions[0] = sql[0..sql.length-5]
      @disciplinas = Disciplina.find(:all, :select => ('id, nome, curso_id'), :conditions => conditions)
      if @disciplinas.empty?
        redirect_to(disciplinas_path, :notice => 'Nenhum resultado encontrado.')
      else
        session[:disciplinas] = @disciplinas
      end
    else
      @disciplinas = session[:disciplinas]
    end
  end

  protected
  def guarda_pesquisa_disciplina
    session[:pesquisa_disciplina] = request.request_uri
    session[:retorno] = session[:pesquisa_disciplina]
  end

  protected
  def guarda_consulta_disciplina
    if session[:pesquisa_disciplina].nil?
      session[:retorno] = request.request_uri
    end
  end
end
