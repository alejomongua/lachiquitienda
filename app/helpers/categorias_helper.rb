module CategoriasHelper
  def default_foto(size)
    image_tag "/images/default_#{size}.png", class: :"main-foto"
  end
end
