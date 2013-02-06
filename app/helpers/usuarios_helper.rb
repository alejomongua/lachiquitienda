#encoding: utf-8

module UsuariosHelper
  # Retorna la imagen de perfil de facebook si está asociado, sinó,
  # retorna el Gravatar (http://gravatar.com/) para el usuario dado
  def imagen_de(usuario, options = { size: 50 })
    fb = usuario.oauths.select(:uid).where(provider: "facebook").first
    if fb.nil?
      gravatar_id = Digest::MD5::hexdigest(usuario.email)
      url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}"
    else
      url = "https://graph.facebook.com/#{fb.uid}/picture"
    end
    image_tag(url, alt: usuario.nombre, class: "avatar")
  end
end