class CreateFotos < ActiveRecord::Migration
  def change
    create_table :fotos do |t|
      t.string :nombre
      t.belongs_to :producto

      t.timestamps
    end
    add_index :fotos, :producto_id
  end
end