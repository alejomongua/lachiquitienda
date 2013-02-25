class CampoProducto < ActiveRecord::Base
  belongs_to :categoria
  attr_accessible :nombre, :requerido, :tipo_campo

  before_save :create_slug
  validates :nombre, presence: true
private
  def create_slug
    self.slug = nombre.parameterize
  end
end
