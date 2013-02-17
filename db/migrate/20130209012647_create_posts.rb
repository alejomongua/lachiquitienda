class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :titulo
      t.text :contenido
      t.integer :autor_id
      t.boolean :publicado

      t.timestamps
    end
    add_index :posts, :publicado
    add_index :posts, :created_at
  end
end
