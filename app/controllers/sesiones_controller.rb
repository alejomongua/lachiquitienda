#encoding: utf-8

class SesionesController < ApplicationController
  def new
    redirect_to root_path if identificado?
  end

  def create
    redirect_to root_path if identificado?
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

  def oauth
    usuario = Oauth.where(env["omniauth.auth"].slice(:provider, :uid)).first_or_initialize do |oauth|
      oauth.token = env["omniauth.auth"].credentials.token
      oauth.expira = Time.at(env["omniauth.auth"].credentials.expires_at)
      if identificado?
        oauth.usuario = usuario_actual
      else
        oauth.usuario = Usuario.where( email: env["omniauth.auth"].info.email ).first_or_create do |user|
          user.nombre = env["omniauth.auth"].info.name
          user.password = user.password_confirmation = SecureRandom.base64
        end
      end
      oauth.save!
    end.usuario
    identificar usuario
    flash[:success] = 'Tu cuenta ha sido vinculada a ' + env["omniauth.auth"].provider
    redirect_back_or root_path
  end
end