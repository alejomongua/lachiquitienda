class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :nick
      t.string :email
      t.string :password_digest
      t.text :acerca_de_mi
      t.string :remember_token
      t.boolean :admin

      t.timestamps
    end
  end
end
