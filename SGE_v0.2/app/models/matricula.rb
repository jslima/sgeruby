class Matricula < ActiveRecord::Base
  belongs_to :aluno
  belongs_to :turma

  validates_presence_of :turma_id
end
