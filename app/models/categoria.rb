class Categoria < ActiveRecord::Base
  attr_accessible :nombre, :campos_attributes, :opciones_attributes, :foto_attributes
  has_many :campos, class_name: "CampoProducto", dependent: :restrict
  has_many :opciones, through: :campos, dependent: :restrict
  has_many :productos
  has_one :foto, dependent: :restrict
  accepts_nested_attributes_for :foto, allow_destroy: true

  accepts_nested_attributes_for :campos, allow_destroy: true
  accepts_nested_attributes_for :opciones, allow_destroy: true

  validates :nombre, presence: true
  validates_uniqueness_of :nombre

  def to_param
    "#{id}-#{nombre}".parameterize
  end

end
