# Limpiamos todas las inflecciones existentes
ActiveSupport::Inflector.inflections.clear

# Agregamos las reglas de inflección
ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural /([^djlnrs])([A-Z]|_|$)/, '\1s\2'
  inflect.plural /([djlnrs])([A-Z]|_|$)/, '\1es\2'
  inflect.plural /(.*)z([A-Z]|_|$)$/i, '\1ces\2'

  inflect.singular /([^djlnrs])s([A-Z]|_|$)/, '\1\2'
  inflect.singular /([djlnrs])es([A-Z]|_|$)/, '\1\2'
  inflect.singular /(.*)ces([A-Z]|_|$)$/i, '\1z\2'

  inflect.irregular 'busqueda_posts', 'busquedas_posts'
end