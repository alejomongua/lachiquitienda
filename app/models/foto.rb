class Foto < ActiveRecord::Base
  belongs_to :producto
  attr_accessible :nombre, :imagen

  has_attached_file :imagen, styles: { normal: "640x480>", thumb: "100x100#" }

  validates_attachment :imagen, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] } ,
    size: { in: 0..1.megabytes }

  def to_param
    "#{id}-#{nombre}".parameterize
  end
end
