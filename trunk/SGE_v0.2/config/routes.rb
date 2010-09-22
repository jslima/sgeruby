SGEV02::Application.routes.draw do

  match 'matriculas/consultar/:id', :to => 'matriculas#consultar', :as => 'consultar_matricula'
  match 'matriculas/editar/:id', :to => 'matriculas#editar', :as => 'editar_matricula'
  match 'matriculas/matricular/:id', :to => 'matriculas#matricular', :as => 'matricular_aluno'

  resources :matriculas, :only => [:create, :update]

  match 'turmas/pesquisar', :to => 'turmas#pesquisar', :as => 'pesquisar_turmas'
  match 'turmas/consultar/:id', :to => 'turmas#consultar', :as => 'consultar_turma'
  match 'turmas/editar/:id', :to => 'turmas#editar', :as => 'editar_turma'
  match 'turmas/novo/', :to => 'turmas#novo', :as => 'nova_turma'

  resources :turmas, :only => [:index, :create, :update, :destroy]

  match 'alunos/pesquisar', :to => 'alunos#pesquisar', :as => 'pesquisar_alunos'
  match 'alunos/consultar/:id', :to => 'alunos#consultar', :as => 'consultar_aluno'
  match 'alunos/editar/:id', :to => 'alunos#editar', :as => 'editar_aluno'
  match 'alunos/novo/', :to => 'alunos#novo', :as => 'novo_aluno'

  resources :alunos, :only => [:index, :create, :update, :destroy]

  match 'cursos/pesquisar', :to => 'cursos#pesquisar', :as => 'pesquisar_cursos'
  match 'cursos/consultar/:id', :to => 'cursos#consultar', :as => 'consultar_curso'
  match 'cursos/editar/:id', :to => 'cursos#editar', :as => 'editar_curso'
  match 'cursos/novo/', :to => 'cursos#novo', :as => 'novo_curso'

  resources :cursos, :only => [:index, :create, :update, :destroy]

  root :to => 'principal#index'

  match ':controller/:action/:id'
  match ':controller/:action/:id.:format'

  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end