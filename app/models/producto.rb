class Producto < ActiveRecord::Base
  attr_accessible :descripcion, :nombre, :precio, :propiedades, 
                  :cantidad, :publicado, :etiqueta_list, :categoria_id,
                  :descuento, :fotos_attributes
  
  belongs_to :categoria
  acts_as_taggable_on :etiquetas
  serialize :propiedades, Hash

  has_many :fotos, dependent: :restrict
  accepts_nested_attributes_for :fotos, allow_destroy: true

  validates_presence_of :categoria
  validates :descripcion, presence: true
  validates :nombre, presence: true
  validates :precio, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cantidad, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :descuento, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :publicado, inclusion: {in: [true, false]}, allow_blank: true
  validate :validar_propiedades

  def validar_propiedades
    unless categoria.nil?
      categoria.campos.each do |field|
        if field.requerido? && propiedades[field.slug].blank?
          errors.add field.nombre, "no debe estar en blanco"
        end
      end
    end
  end

  def to_param
    "#{id}-#{nombre}".parameterize
  end
end
