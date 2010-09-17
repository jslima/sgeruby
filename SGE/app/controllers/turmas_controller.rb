class TurmasController < ApplicationController
  before_filter :limpar_sessao, :only => [:index]
  before_filter :guarda_pesquisa_turma, :only => [:pesquisar]
  before_filter :guarda_consulta_turma, :only => [:consultar]

  # GET /turmas
  # GET /turmas.xml
  def index
    @turmas = Turma.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @turmas }
    end
  end

  # GET /turmas/1
  # GET /turmas/1.xml
  def consultar
    @turma = Turma.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @turma }
    end
  end

  # GET /turmas/new
  # GET /turmas/new.xml
  def novo
    @turma = Turma.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @turma }
    end
  end

  # GET /turmas/1/edit
  def editar
    @turma = Turma.find(params[:id])
  end

  # POST /turmas
  # POST /turmas.xml
  def create
    @turma = Turma.new(params[:turma])

    respond_to do |format|
      if @turma.save
        format.html { redirect_to(consultar_turma_path(@turma), :notice => 'Turma was successfully created.') }
        format.xml  { render :xml => @turma, :status => :created, :location => @turma }
      else
        format.html { render :action => "novo" }
        format.xml  { render :xml => @turma.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /turmas/1
  # PUT /turmas/1.xml
  def update
    @turma = Turma.find(params[:id])

    respond_to do |format|
      if @turma.update_attributes(params[:turma])
        format.html { redirect_to(consultar_turma_path(@turma), :notice => 'Turma was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "editar" }
        format.xml  { render :xml => @turma.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /turmas/1
  # DELETE /turmas/1.xml
  def destroy
    @turma = Turma.find(params[:id])
    @turma.destroy

    respond_to do |format|
      format.html { redirect_to(turmas_url) }
      format.xml  { head :ok }
    end
  end

  def pesquisar
    if !params[:nome].nil? or !params[:ano].nil? or !params[:curso_id].nil?
      conditions = [""]
      sql = ""
      if !params[:nome].empty?
        sql = sql + "(UPPER(nome) LIKE UPPER(?)) AND "
        conditions <<  "%#{params[:nome]}%"
      end
      if !params[:ano].empty?
        sql = sql + "ano = ? AND "
        conditions <<  "#{params[:ano]}"
      end
      if !params[:curso_id].empty?
        sql = sql + "curso_id = ? AND "
        conditions <<  "#{params[:curso_id]}"
      end
      conditions[0] = sql[0..sql.length-5]
      @turmas = Turma.find(:all, :select => ('id, nome, ano, curso_id'), :conditions => conditions)
      if @turmas.empty?
        redirect_to(turmas_path, :notice => 'Nenhum resultado encontrado.')
      else
        session[:turmas] = @turmas
      end
    else
      @turmas = session[:turmas]
    end
  end
end
