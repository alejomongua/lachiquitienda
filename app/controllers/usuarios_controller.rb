#encoding: utf-8

class UsuariosController < ApplicationController
  before_filter :usuario_identificado, except: [:new, :create, :olvide_contrasena, :generar_tokens]
  before_filter :no_identificado, only: [:new, :create, :olvide_contrasena, :generar_tokens]
  before_filter :usuario_correcto,      only: [:show, :edit, :update]
  before_filter :administrar_usuarios,         only: [:destroy, :index]

  def new
    @usuario = Usuario.new
  end

  def show
  end

  def edit    
  end

  def update
    if params[:usuario][:password].blank?
      params[:usuario].delete(:password)
      params[:usuario].delete(:password_confirmation)
    end
    @usuario.token=""
    if @usuario.update_attributes(params[:usuario])
      identificar @usuario if usuario_actual?(@usuario)
      flash[:success] = "Perfil actualizado"
      redirect_to @usuario
    else
      flash.now[:success] = "No se pudo actualizar el perfil"
      render 'edit'
    end
  end

  def index
    @usuarios = Usuario.busqueda(params[:buscar]).paginate(page: params[:page])
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    if @usuario.save
      CorreoUsuarios.bienvenida(@usuario).deliver
      flash[:success] = "#{@usuario.nombre} creado exitosamente"
      identificar @usuario
      redirect_to usuarios_path
    else
      flash.now[:error] = "No se pudo crear el usuario"
      render 'new'
    end
  end

  def destroy
    Usuario.find(params[:id]).destroy
    flash[:success] = "Usuario eliminado"
    redirect_to usuarios_url
  end

  def generar_tokens
    usuario = Usuario.find_by_email(params[:email].downcase)
    if usuario
      usuario.generar_token
      CorreoUsuarios.olvide_contrasena(usuario).deliver
      redirect_to root_path, notice: "Se ha enviado un correo a #{params[:email]} con instrucciones para restablecer la contraseña"
    else
      redirect_to olvide_contrasena_path, notice: "No se encontró el usuario"
    end
  end

  def olvide_contrasena
    if params[:u]
      @usuario = Usuario.find(params[:u])
      if @usuario.token == params[:token] && @usuario.fecha_token.to_time > Time.now
        identificar @usuario
        render 'modificar_contrasena'
      else
        redirect_to root_path 
      end
    else
      render 'recuperar_contrasena'
    end
  end

private

  def usuario_correcto
    @usuario = Usuario.find(params[:id])
    redirect_to(root_path) unless (usuario_actual?(@usuario) || usuario_actual.admin?)
  end

  def administrar_usuarios
    redirect_to(root_path) unless usuario_actual.admin?
  end

  def no_identificado
    redirect_to root_path unless !identificado?
  end
end