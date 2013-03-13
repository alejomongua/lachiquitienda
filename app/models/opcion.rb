class Opcion < ActiveRecord::Base
  belongs_to :campo_producto
  attr_accessible :nombre, :valor

  validates :nombre, presence: true
  before_save :asignar_valor

private
  def asignar_valor
    if valor.blank?
      self.valor = self.nombre.parameterize
    else
      self.valor = valor.parameterize
    end
  end
end
