class Disciplina < ActiveRecord::Base
  belongs_to :curso

  validates :nome, :curso_id, :presence => true

end
