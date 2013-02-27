class CampoProducto < ActiveRecord::Base
  TIPOS = %w[texto texto_extenso numero decimal check_box]
  belongs_to :categoria
  attr_accessible :nombre, :requerido, :tipo_campo

  before_save :create_slug
  validates :nombre, presence: true
  validates :tipo_campo, inclusion: { in: TIPOS }
private
  def create_slug
    self.slug = nombre.parameterize
  end
end
