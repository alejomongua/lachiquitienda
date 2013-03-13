class Opcion < ActiveRecord::Base
  belongs_to :campo_producto
  attr_accessible :nombre, :valor
end
