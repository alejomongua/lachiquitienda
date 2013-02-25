class AddSlugToCampoCategoria < ActiveRecord::Migration
  def change
    add_column :campos_productos, :slug, :string
  end
end
