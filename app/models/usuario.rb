class Usuario < ActiveRecord::Base
  # Constantes
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Accesibilidad
  attr_accessible :email, :nombre, :password, :password_confirmation, :telefono,
                  :admin, :nick, :acerca_de_mi, :genero, :direccion, :ciudad
                  
  has_secure_password

  # Filtros
  before_save do |user|
    self.email.downcase!
    user.admin = false if admin.nil?
    user.nombre = nombre.split(' ').each{|word| word.capitalize!}.join(' ')
    create_remember_token
    self.nick = nombre.split(' ').first if nick.blank?
  end

  # Validaciones
  validates :nombre, presence: true, length: { in: 6..50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  has_many :oauths
  has_many :items
  has_many :pedidos

  def self.busqueda(s)
    if s
      where('lower(nombre) LIKE ?', "%#{s.downcase}%")
    else
      where('nombre LIKE ?', "%#{}%")
    end
  end

  def generar_token
    self.token = SecureRandom.urlsafe_base64
    self.fecha_token = Time.now + 1.day
    self.save
  end

  def genero= (gen)
    if gen == "Hombre"
      self.gender = 'h'
    elsif gen =="Mujer"
      self.gender = 'm'
    end
  end

  def genero
    if self.gender == "h"
      "Hombre"
    elsif self.gender =="m"
      "Mujer"
    else
      nil
    end
  end

private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end