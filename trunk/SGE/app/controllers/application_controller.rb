# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

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
end