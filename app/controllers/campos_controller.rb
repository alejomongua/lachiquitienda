class CamposController < ApplicationController
  before_filter :administrar_blog
  respond_to :json

  def categoria
    @campos = Categoria.find(params[:id]).campos.select('slug, nombre, tipo_campo')
    render json: @campos
  end
private
  def administrar_blog
    unless identificado? && usuario_actual.admin
      redirect_to root_path
    end
  end
end