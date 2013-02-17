class Post < ActiveRecord::Base
  attr_accessible :titulo, :contenido, :publicado, :autor, :tag_list

  acts_as_taggable
  belongs_to :autor, class_name: "Usuario"

  validates_presence_of :autor
  validates :publicado, inclusion: {in: [true, false]}, allow_blank: true
  validates :titulo, presence: true
  validates :contenido, presence: true

  def to_param
    "#{id}-#{titulo}".parameterize
  end

#  def relacionados
 #   tagged_with(self.tag_list, any: true)
  #end
end
