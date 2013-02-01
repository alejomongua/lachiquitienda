#encoding: utf-8

module UsuariosHelper
  # Retorna la imagen de perfil de facebook si está asociado, sinó,
  # retorna el Gravatar (http://gravatar.com/) para el usuario dado
  def imagen_de(usuario, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(usuario.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}"
    image_tag(gravatar_url, alt: usuario.nombre, class: "gravatar")
  end
end