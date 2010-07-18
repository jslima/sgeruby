class Matricula < ActiveRecord::Base
  belongs_to :aluno
  belongs_to :turma
end
