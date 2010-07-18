class Turma < ActiveRecord::Base
  has_many :matriculas
  belongs_to :curso
end
