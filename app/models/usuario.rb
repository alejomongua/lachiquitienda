class Usuario < ActiveRecord::Base
  # Constantes
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Accesibilidad
  attr_accessible :email, :nombre, :password, :password_confirmation,
                  :admin, :nick, :acerca_de_mi
                  
  has_secure_password

  # Filtros
  before_save do |user|
    self.email.downcase!
    user.admin = false if admin.nil?
    user.nombre = nombre.split(' ').each{|word| word.capitalize!}.join(' ')
    create_remember_token
  end

  # Validaciones
  validates :nombre, presence: true, length: { in: 6..50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  def self.busqueda(s)
    if s
      where('lower(nombre) LIKE ?', "%#{s.downcase}%")
    else
      where('nombre LIKE ?', "%#{}%")
    end
  end

private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end