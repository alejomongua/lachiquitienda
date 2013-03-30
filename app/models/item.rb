class Item < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :producto
  belongs_to :pedido
  attr_accessible :cantidad, :precio, :producto_id, :pedido_id

  validates_presence_of :producto
  validates :cantidad, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :asignar_precio

  scope :en_carrito, where(pedido_id: nil)

  def total
    self.precio * self.cantidad
  end
private
  def asignar_precio
    if precio.nil?
      if producto.descuento == nil
        self.precio = producto.precio 
      else
        self.precio = producto.precio - producto.descuento
      end
    end
  end
end
