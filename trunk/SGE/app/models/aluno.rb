class Aluno < ActiveRecord::Base
  belongs_to :curso

  def image_file=(input_data)
    self.foto_nome = input_data.original_filename
    self.foto_content_type = input_data.content_type.chomp
    self.foto_bin_data = input_data.read
  end
  
end
