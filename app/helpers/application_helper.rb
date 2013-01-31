#encoding: utf-8

module ApplicationHelper
  # retorna el tìtulo completo.
  def titulo_completo(titulo)
    titulo_base = "Nombre de la aplicación"
    if titulo.empty?
      titulo_base
    else
      "#{titulo} | #{titulo_base}"
    end
  end
end
