class AddCategoriaIdToFotos < ActiveRecord::Migration
  def change
    add_column :fotos, :categoria_id, :integer
  end
end
