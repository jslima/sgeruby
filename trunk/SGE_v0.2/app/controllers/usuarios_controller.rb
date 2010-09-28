class UsuariosController < ApplicationController
  before_filter :limpar_sessao, :only => [:index]
  before_filter :guarda_pesquisa_usuario, :only => [:pesquisar]
  before_filter :guarda_consulta_usuario, :only => [:consultar]
  before_filter :is_admin, :except => [:login, :logout]

  skip_before_filter :logado
  
  layout :usuario_layout
  require 'digest'

  protected
  def usuario_layout
    action_name == "login" ? "login" : "application"
  end

  def login
    if !params[:usuario].nil?
      session[:usuario] = params[:usuario]['nome']
      senha = Digest::SHA1.hexdigest(session[:salt] + params[:usuario]['senha'])
      @usuario = Usuario.find(:all, :select => ('id, administrador'),
        :conditions => ["nome = ? AND senha = ?", params[:usuario]['nome'], senha])
      if !@usuario.empty?
        session[:usuario] = {'nome' => params[:usuario]['nome'], 'admin' => @usuario[0]['administrador']}
        redirect_to session[:return_to]
      else
        flash[:notice] = "Usuario e/ou senha incorretos";
        redirect_to login_path
      end
    end
  end

  def logout
    if !session[:usuario].nil?
      session[:usuario] = nil
      redirect_to login_path
    end
  end

  def index
    @usuarios = Usuario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usuarios }
    end
  end

  # GET /alunos/1
  # GET /alunos/1.xml
  def consultar
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /alunos/new
  # GET /alunos/new.xml
  def novo
    @usuario = Usuario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /alunos/1/edit
  def editar
    @usuario = Usuario.find(params[:id])
  end

  # POST /alunos
  # POST /alunos.xml
  def create
    @usuario = Usuario.new(params[:usuario])

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to(consultar_usuario_path(@usuario), :notice => 'O usuário foi criado com sucesso.') }
        format.xml  { render :xml => @usuario, :status => :created, :location => @usuario }
      else
        format.html { render :action => "novo" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /alunos/1
  # PUT /alunos/1.xml
  def update
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        format.html { redirect_to(consultar_usuario_path(@usuario), :notice => 'O usuário foi editado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "editar" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /alunos/1
  # DELETE /alunos/1.xml
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to(usuarios_url) }
      format.xml  { head :ok }
    end
  end

  def pesquisar
    if !params[:usuario].nil?
      conditions = [""]
      sql = ""
      if !params[:usuario].empty?
        sql = sql + "(UPPER(nome) LIKE UPPER(?)) AND "
        conditions <<  "%#{params[:usuario]}%"
      end
      conditions[0] = sql[0..sql.length-5]
      @usuarios = Usuario.find(:all, :select => ('id, usuario'), :conditions => conditions)
      if @usuarios.empty?
        redirect_to(alunos_path, :notice => 'Nenhum resultado encontrado.')
      else
        session[:usuarios] = @usuarios
      end
    else
      @usuarios = session[:usuarios]
    end
  end
end
