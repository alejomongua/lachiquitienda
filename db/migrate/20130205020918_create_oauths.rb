class CreateOauths < ActiveRecord::Migration
  def change
    create_table :oauths do |t|
      t.string :uid
      t.integer :usuario_id
      t.string :provider
      t.string :token
      t.datetime :expira

      t.timestamps
    end
  end
end
