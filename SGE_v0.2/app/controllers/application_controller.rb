# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :logado
  before_filter :get_salt

  protected
  def is_admin
    unless session[:usuario]['admin'] == 1
      flash[:notice] = "Você não tem permissão do administrador para acessar esta pagina"
      redirect_to :root
    end
  end

  def get_salt
    session[:salt] = "Ae8nv021cYoa1346PoaEm"
  end

  protected
  def logado
    if session[:usuario].nil?
      session[:return_to] = request.request_uri
      flash[:notice] = 'Você deve estar logado para acessar esta pagina'
      redirect_to login_path
    end
  end

  protected
  def limpar_sessao
    session[:pesquisa_curso] = nil
    session[:pesquisa_aluno] = nil
    session[:retorno] = nil
  end

  protected
  def guarda_pesquisa_curso
    session[:pesquisa_curso] = request.request_uri
    session[:retorno] = session[:pesquisa_curso]
  end

  protected
  def guarda_consulta_curso
    if session[:pesquisa_curso].nil?
      session[:retorno] = request.request_uri
    end
  end
  
  protected
  def guarda_pesquisa_aluno
    session[:pesquisa_aluno] = request.request_uri
    session[:retorno] = session[:pesquisa_aluno]
  end

  protected
  def guarda_consulta_aluno
    if session[:pesquisa_aluno].nil?
      session[:retorno] = request.request_uri
    end
  end

  protected
  def guarda_pesquisa_turma
    session[:pesquisa_turma] = request.request_uri
    session[:retorno] = session[:pesquisa_turma]
  end

  protected
  def guarda_consulta_turma
    if session[:pesquisa_turma].nil?
      session[:retorno] = request.request_uri
    end
  end
end