class Curso < ActiveRecord::Base
  has_many :alunos
  
  validates_presence_of :nome, :descricao, :ementa, :coordenador, :turno, :duracao, :total_horas, :tipo
  validates_numericality_of :duracao, :total_horas
end
