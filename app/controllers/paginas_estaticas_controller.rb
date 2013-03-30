class PaginasEstaticasController < ApplicationController
  def inicio
    @posts = Post.publicados.limit(3)
    @productos = Producto.destacados.limit(6)
  end

  def politica_de_privacidad
  end

  def agradecimientos
  end

  def acerca_de
    
  end
end