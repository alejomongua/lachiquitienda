#encoding: utf-8

class CorreoUsuarios < ActionMailer::Base
  default from: "from@example.com"
  def bienvenida(usuario)
    @usuario = usuario
    mail(to: "#{usuario.nombre} <#{usuario.email}>", subject: "Bienvenido")
  end

  def olvide_contrasena(usuario)
    @usuario = usuario
    mail(to: "#{usuario.nombre} <#{usuario.email}>", subject: "Olvido de contraseña")
  end
end
