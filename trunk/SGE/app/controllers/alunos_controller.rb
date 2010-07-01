class AlunosController < ApplicationController
  before_filter :limpar_sessao, :only => [:index]
  before_filter :guarda_pesquisa_aluno, :only => [:pesquisar]
  before_filter :guarda_consulta_aluno, :only => [:consultar]
  
  # GET /alunos
  # GET /alunos.xml
  def index
    @alunos = Aluno.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alunos }
    end
  end

  # GET /alunos/1
  # GET /alunos/1.xml
  def consultar
    @aluno = Aluno.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @aluno }
    end
  end

  # GET /alunos/new
  # GET /alunos/new.xml
  def novo
    @aluno = Aluno.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @aluno }
    end
  end

  # GET /alunos/1/edit
  def editar
    @aluno = Aluno.find(params[:id])
  end

  # POST /alunos
  # POST /alunos.xml
  def create
    @aluno = Aluno.new(params[:aluno])

    respond_to do |format|
      if @aluno.save
        format.html { redirect_to(consultar_aluno_path(@aluno), :notice => 'O aluno foi criado com sucesso.') }
        format.xml  { render :xml => @aluno, :status => :created, :location => @aluno }
      else
        format.html { render :action => "novo" }
        format.xml  { render :xml => @aluno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /alunos/1
  # PUT /alunos/1.xml
  def update
    @aluno = Aluno.find(params[:id])

    respond_to do |format|
      if @aluno.update_attributes(params[:aluno])
        format.html { redirect_to(consultar_aluno_path(@aluno), :notice => 'O aluno foi editado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "editar" }
        format.xml  { render :xml => @aluno.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /alunos/1
  # DELETE /alunos/1.xml
  def destroy
    @aluno = Aluno.find(params[:id])
    @aluno.destroy

    respond_to do |format|
      format.html { redirect_to(alunos_url) }
      format.xml  { head :ok }
    end
  end

  def pesquisar
    if !params[:nome].nil? or !params[:matricula].nil? or !params[:curso_id].nil?
      conditions = [""]
      sql = ""
      if !params[:nome].empty?
        sql = sql + "(UPPER(nome) LIKE UPPER(?)) AND "
        conditions <<  "%#{params[:nome]}%"
      end
      if !params[:matricula].empty?
        sql = sql + "(UPPER(matricula) LIKE UPPER(?)) AND "
        conditions << "%#{params[:matricula]}%"
      end
      if !params[:curso_id].empty?
        sql = sql + "curso_id = ? AND "
        conditions << "#{params[:curso_id]}"
      end
      conditions[0] = sql[0..sql.length-5]
      @alunos = Aluno.find(:all, :select => ('id, nome, matricula'), :conditions => conditions)
      if @alunos.empty?
        redirect_to(alunos_path, :notice => 'Nenhum resultado encontrado.')
      else
        session[:alunos] = @alunos
      end
    else
      @alunos = session[:alunos]
    end
  end

  def code_image
    @aluno = Aluno.find(params[:id])
    @image = @aluno.foto_bin_data
    send_data(@image, :type => @aluno.foto_content_type, :filename => @aluno.foto_nome, :disposition => 'inline')
  end

end
