class Producto < ActiveRecord::Base
  attr_accessible :descripcion, :nombre, :precio, :propiedades, 
                  :cantidad, :publicado, :etiqueta_list, :categoria_id
  
  belongs_to :categoria
  acts_as_taggable_on :etiquetas
  serialize :propiedades, Hash

  validates_presence_of :categoria
  validates :descripcion, presence: true
  validates :nombre, presence: true
  validates :precio, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cantidad, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :publicado, inclusion: {in: [true, false]}, allow_blank: true
  validate :validar_propiedades

  def validar_propiedades
    categoria.campos.each do |field|
      if field.requerido? && propiedades[field.nombre].blank?
        errors.add field.nombre, "no debe estar en blanco"
      end
    end
  end
end
