class Matricula < ActiveRecord::Base
  has_many :alunos
  has_many :turmas
end
