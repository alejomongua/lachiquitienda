class CampoProducto < ActiveRecord::Base
  TIPOS = %w[texto texto_extenso numero decimal check_box opciones]
  belongs_to :categoria
  attr_accessible :nombre, :requerido, :tipo_campo, :filtro, :opciones_attributes
  has_many :opciones
  accepts_nested_attributes_for :opciones, allow_destroy: true
  
  before_save :create_slug
  validates :nombre, presence: true
  validates :tipo_campo, inclusion: { in: TIPOS }
private
  def create_slug
    self.slug = nombre.parameterize
  end
end
