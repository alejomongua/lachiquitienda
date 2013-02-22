class CampoProducto < ActiveRecord::Base
  belongs_to :categoria
  attr_accessible :nombre, :requerido, :tipo_campo
end
