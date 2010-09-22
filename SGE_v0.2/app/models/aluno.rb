class Aluno < ActiveRecord::Base
  has_many :matriculas

  def image_file=(input_data)
    self.foto_nome = input_data.original_filename
    self.foto_content_type = input_data.content_type.chomp
    self.foto_bin_data = input_data.read
  end
  
end
