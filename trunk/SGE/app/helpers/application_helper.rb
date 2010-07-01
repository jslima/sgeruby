# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def tipo_cursos
    tipo_cursos = [["---------", ""],
      ["Graduação", "Graduação"],
      ["Pós-Graduação", "Pós-Graduação"]]
  end
  def lista_cursos
    lista_cursos = Curso.find(:all)
  end
  def lista_estados
    tipo_cursos = [["---------", ""],
      ["AC", "AC"],
      ["MG", "MG"]]
  end
end
