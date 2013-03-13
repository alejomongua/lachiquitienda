class Categoria < ActiveRecord::Base
  attr_accessible :nombre, :campos_attributes, :opciones_attributes
  has_many :campos, class_name: "CampoProducto"
  has_many :opciones, through: :campos
  accepts_nested_attributes_for :campos, allow_destroy: true
  accepts_nested_attributes_for :opciones, allow_destroy: true

  validates :nombre, presence: true
  validates_uniqueness_of :nombre
end
