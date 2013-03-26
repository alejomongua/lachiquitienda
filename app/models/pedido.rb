class Pedido < ActiveRecord::Base
  belongs_to :usuario
  attr_accessible :ciudad_envio, :costo_envio, :destinatario, :direccion_envio,
                  :telefono, :numero_consignacion, :fecha_consignacion, :estado,
                  :guia, :tipo_envio, :tipo_pago

  has_many :items
end
