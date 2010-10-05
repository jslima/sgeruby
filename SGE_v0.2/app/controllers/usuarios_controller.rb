class UsuariosController < ApplicationController
  before_filter :limpar_sessao, :only => [:index]
  before_filter :guarda_pesquisa_usuario, :only => [:pesquisar]
  before_filter :guarda_consulta_usuario, :only => [:consultar]
  #before_filter :is_admin, :except => [:login, :logout]
 
  layout :usuario_layout
  require 'digest'

  def usuario_layout
    action_name == "login" ? "login" : "application"
  end

  def login
    if !params[:nome].nil? or !params[:senha].nil?
      senha = Digest::SHA1.hexdigest(session[:salt] + params[:senha])
      @usuario = Usuario.find_by_nome(params[:nome])
      if @usuario.senha == senha
        session[:usuario] = {'nome' => params[:nome], 'admin' => @usuario.administrador}
        redirect_to session[:return_to]
      else
        flash[:notice] = "Usuario e/ou senha incorretos";
        redirect_to login_path
      end      
    end
  end

  def mudar_senha
    if !params[:nova_senha].nil? or !params[:nova_senha2].nil?
      respond_to do |format|
        if params[:nova_senha] == params[:nova_senha2]
          senha = Digest::SHA1.hexdigest(session[:salt] + params[:nova_senha])
          @usuario = Usuario.find_by_nome(session[:usuario]['nome'])
          if @usuario.update_attribute('senha', senha)
            format.html { redirect_to(mudar_senha_path, :notice => 'A senha foi alterada com sucesso.') }
          end
        else
          flash[:notice] = "A nova senha e a confirmação devem ser iguais"
          redirect_to mudar_senha_path
        end
      end
    end
  end

  def logout
    session[:usuario] = nil
    redirect_to login_path
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
      if !params[:senha2].nil?
        if @usuario.senha == params[:senha2]
          @usuario.senha = Digest::SHA1.hexdigest(session[:salt] + params[:senha2])
          if @usuario.save
            format.html { redirect_to(consultar_usuario_path(@usuario), :notice => 'O usuário foi criado com sucesso.') }
            format.xml  { render :xml => @usuario, :status => :created, :location => @usuario }
          else
            format.html { render :action => "novo" }
            format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
          end
        else
          flash[:notice] = "A senha e a confirmação devem ser iguais"
          redirect_to novo_usuario_path
        end
      end
    end
  end

  # PUT /alunos/1
  # PUT /alunos/1.xml
  def update
    @usuario = Usuario.find(params[:id])
    @usuario.senha = Digest::SHA1.to_s(@usuario.senha)

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
    if !params[:nome].nil?
      conditions = [""]
      sql = ""
      if !params[:nome].empty?
        sql = sql + "(UPPER(nome) LIKE UPPER(?)) AND "
        conditions <<  "%#{params[:nome]}%"
      end
      conditions[0] = sql[0..sql.length-5]
      @usuarios = Usuario.find(:all, :select => ('id, nome'), :conditions => conditions)
      if @usuarios.empty?
        redirect_to(alunos_path, :notice => 'Nenhum resultado encontrado.')
      else
        session[:usuarios] = @usuarios
      end
    else
      @usuarios = session[:usuarios]
    end
  end

  protected
  def guarda_pesquisa_usuario
    session[:pesquisa_usuario] = request.request_uri
    session[:retorno] = session[:pesquisa_usuario]
  end

  protected
  def guarda_consulta_usuario
    if session[:pesquisa_usuario].nil?
      session[:retorno] = request.request_uri
    end
  end
end
