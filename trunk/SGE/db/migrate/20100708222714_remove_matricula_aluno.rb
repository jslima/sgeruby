class RemoveMatriculaAluno < ActiveRecord::Migration
  def self.up
    remove_column :alunos, :matricula
  end

  def self.down
  end
end
