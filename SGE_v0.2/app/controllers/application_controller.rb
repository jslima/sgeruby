# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :logado, :except => [:login,:teste]
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
    if session[:usuario].nil? || session[:usuario].empty?
      unless request.request_uri == '/usuarios/login'
        session[:return_to] = request.request_uri
        flash[:notice] = 'Você deve estar logado para acessar esta pagina'
        redirect_to login_path
      else
        session[:return_to] = '/'
        flash[:notice] = 'Você deve estar logado para acessar esta pagina'
        redirect_to login_path
      end      
    end
  end

  protected
  def limpar_sessao
    session[:pesquisa_curso] = nil
    session[:pesquisa_aluno] = nil
    session[:pesquisa_turma] = nil
    session[:pesquisa_disciplina] = nil
    session[:retorno] = nil
  end 
end