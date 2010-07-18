ActionController::Routing::Routes.draw do |map|
  map.consultar_matricula '/matriculas/consultar/:id', :controller => 'matriculas', :action => 'consultar'
  map.editar_aluno '/matriculas/editar/:id', :controller => 'matriculas', :action => 'editar'
  map.matricular_aluno '/matriculas/matricular/:id', :controller => 'matriculas', :action => 'matricular'

  map.resources :matriculas, :only => [:create, :update]

  map.resources :turmas

  map.pesquisar_aluno '/aluno/pesquisar', :controller => 'alunos', :action => 'pesquisar'
  map.consultar_aluno '/aluno/consultar/:id', :controller => 'alunos', :action => 'consultar'
  map.editar_aluno '/aluno/editar/:id', :controller => 'alunos', :action => 'editar'
  map.novo_aluno '/aluno/novo', :controller => 'alunos', :action => 'novo'

  map.resources :alunos, :only => [:index, :create, :update, :destroy]

  map.pesquisar_curso '/cursos/pesquisar', :controller => 'cursos', :action => 'pesquisar'
  map.consultar_curso '/cursos/consultar/:id', :controller => 'cursos', :action => 'consultar'
  map.editar_curso '/cursos/editar/:id', :controller => 'cursos', :action => 'editar'
  map.novo_curso '/cursos/novo', :controller => 'cursos', :action => 'novo'

  map.resources :cursos, :only => [:index, :create, :update, :destroy]

  map.root :controller => 'principal', :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
