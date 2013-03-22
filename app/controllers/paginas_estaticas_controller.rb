class PaginasEstaticasController < ApplicationController
  def inicio
    @posts = Post.publicados.limit(5)
    @productos = Producto.publicados.limit(6)
  end

  def politica_de_privacidad
  end

  def agradecimientos
  end

  def acerca_de
    
  end
end