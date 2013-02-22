class Categoria < ActiveRecord::Base
  attr_accessible :nombre, :campos_attributes
  has_many :campos, class_name: "CampoProducto"
  accepts_nested_attributes_for :campos, allow_destroy: true
end
