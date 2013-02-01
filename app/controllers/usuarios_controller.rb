#encoding: utf-8

class UsuariosController < ApplicationController
  before_filter :usuario_identificado,  except: [:new, :create]
  before_filter :usuario_correcto,      only: [:show, :edit, :update]
  before_filter :administrar_usuarios,         only: [:destroy, :index]

  def new
    redirect_to root_path unless !identificado?
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
    @usuarios = Usuario.paginate(page: params[:page])
  end

  def create
    redirect_to root_path unless !identificado?
    @usuario = Usuario.new(params[:usuario])
    if @usuario.save
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

private

  def usuario_correcto
    @usuario = Usuario.find(params[:id])
    redirect_to(root_path) unless (usuario_actual?(@usuario) || usuario_actual.admin?)
  end

  def administrar_usuarios
    redirect_to(root_path) unless usuario_actual.admin?
  end
end