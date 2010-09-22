class CreateMatriculas < ActiveRecord::Migration
  def self.up
    create_table :matriculas do |t|
      t.string :matricula
      t.integer :aluno_id
      t.integer :turma_id

      t.timestamps
    end
  end

  def self.down
    drop_table :matriculas
  end
end
