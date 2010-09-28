class AlterUser < ActiveRecord::Migration
  def self.up
    rename_column :usuarios, :usuario, :nome
  end

  def self.down
  end
end
