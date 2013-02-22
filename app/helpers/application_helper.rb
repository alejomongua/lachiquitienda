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

  def link_to_add_fields(nombre, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_campos", f: builder)
    end
    link_to(nombre, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
