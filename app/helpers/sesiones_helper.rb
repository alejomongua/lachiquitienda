#encoding: utf-8

module SesionesHelper
  def identificar(usuario, recordar=false)
    if recordar == "si"
      cookies.permanent[:remember_token] = usuario.remember_token
    else
      cookies[:remember_token] = usuario.remember_token
    end
    self.usuario_actual = usuario
    if session[:guest_token]
      Item.where(guest_token: session[:guest_token]).update_all(usuario_id: usuario.id, guest_token: '')
      session.delete(:guest_token)
    end
  end

  def identificado?
    !usuario_actual.nil?
  end

  def salir
    self.usuario_actual = nil
    cookies.delete(:remember_token)
    reset_session
  end

  def usuario_actual=(usuario)
    @usuario_actual = usuario
  end

  def usuario_actual
    @usuario_actual ||= Usuario.find_by_remember_token(cookies[:remember_token])
  end

  def usuario_actual?(usuario)
    usuario == usuario_actual
  end

  def usuario_identificado
    unless identificado?
      almacenar_ubicacion
      redirect_to root_url, notice: "Por favor identificate"
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def almacenar_ubicacion
    session[:return_to] = request.url
  end

  def usuario_actual_admin?
    identificado? && usuario_actual.admin?
  end
end
