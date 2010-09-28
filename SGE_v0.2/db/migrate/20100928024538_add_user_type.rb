class AddUserType < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :administrador, :integer
  end

  def self.down
  end
end
