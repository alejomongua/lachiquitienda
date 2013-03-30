# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20130322164216) do
=======
ActiveRecord::Schema.define(:version => 20130326132433) do
>>>>>>> origin/master

  create_table "campos_productos", :force => true do |t|
    t.string   "nombre"
    t.string   "tipo_campo"
    t.boolean  "requerido"
    t.integer  "categoria_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "slug"
    t.boolean  "filtro"
    t.boolean  "opcion"
  end

  add_index "campos_productos", ["categoria_id"], :name => "index_campos_productos_on_categoria_id"

  create_table "categorias", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fotos", :force => true do |t|
    t.string   "nombre"
    t.integer  "producto_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.integer  "categoria_id"
  end

  add_index "fotos", ["producto_id"], :name => "index_fotos_on_producto_id"

  create_table "items", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "producto_id"
    t.integer  "pedido_id"
    t.integer  "cantidad"
    t.integer  "precio"
    t.string   "guest_token"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "items", ["guest_token"], :name => "index_items_on_guest_token"
  add_index "items", ["pedido_id"], :name => "index_items_on_pedido_id"
  add_index "items", ["producto_id"], :name => "index_items_on_producto_id"
  add_index "items", ["usuario_id"], :name => "index_items_on_usuario_id"

  create_table "oauths", :force => true do |t|
    t.string   "uid"
    t.integer  "usuario_id"
    t.string   "provider"
    t.string   "token"
    t.datetime "expira"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "opciones", :force => true do |t|
    t.string   "nombre"
    t.string   "valor"
    t.integer  "campo_producto_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "opciones", ["campo_producto_id"], :name => "index_opciones_on_campo_producto_id"

  create_table "pedidos", :force => true do |t|
    t.string   "guia"
    t.integer  "costo_envio"
    t.string   "tipo_envio"
    t.string   "direccion_envio"
    t.string   "ciudad_envio"
    t.string   "destinatario"
    t.string   "tipo_pago"
    t.string   "estado"
    t.integer  "usuario_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "pedidos", ["usuario_id"], :name => "index_pedidos_on_usuario_id"

  create_table "posts", :force => true do |t|
    t.string   "titulo"
    t.text     "contenido"
    t.integer  "autor_id"
    t.boolean  "publicado"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "posts", ["created_at"], :name => "index_posts_on_created_at"
  add_index "posts", ["publicado"], :name => "index_posts_on_publicado"

  create_table "productos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "categoria_id"
    t.integer  "precio"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "propiedades"
    t.integer  "cantidad"
    t.boolean  "publicado"
    t.integer  "descuento"
    t.boolean  "destacado"
  end

  add_index "productos", ["categoria_id"], :name => "index_productos_on_categoria_id"
  add_index "productos", ["created_at"], :name => "index_productos_on_created_at"
  add_index "productos", ["destacado"], :name => "index_productos_on_destacado"
  add_index "productos", ["publicado"], :name => "index_productos_on_publicado"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "nick"
    t.string   "gender"
    t.string   "email"
    t.string   "password_digest"
    t.text     "acerca_de_mi"
    t.string   "remember_token"
    t.string   "token"
    t.date     "fecha_token"
    t.boolean  "admin"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
