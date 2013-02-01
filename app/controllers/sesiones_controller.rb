#encoding: utf-8

class SesionesController < ApplicationController
  def new
  end

  def create
    usuario = Usuario.find_by_email(params[:sesion][:email].downcase)
    if usuario && usuario.authenticate(params[:sesion][:password])
      identificar usuario, params[:sesion][:recordar]
      redirect_back_or root_path
    else
      flash[:error] = 'Combinación de correo/contraseña erronea'
      redirect_to identificate_path
    end
  end
  
  def destroy
    salir
    redirect_to root_url
  end

end
