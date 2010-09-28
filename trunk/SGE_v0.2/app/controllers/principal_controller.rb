class PrincipalController < ApplicationController
    before_filter :get_salt
  
  def index
    #session[:usuario] = {'nome' => 'teste', 'admin' => 1}
    #@teste = Digest::SHA1.hexdigest(session[:salt] + 'teste')
    #@nome = session[:usuario]['nome']
    #@admin = session[:usuario]['admin']
  end

  def sobre    
  end  

end
