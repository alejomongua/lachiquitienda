namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    crear_usuarios
    crear_posts
    crear_categorias
    crear_productos
    crear_fotos
  end
end

def crear_usuarios
  admin = Usuario.create!(nombre:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(nombre:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def crear_posts
  50.times do |n|
    usuario = Usuario.first
    content = Faker::Lorem.sentence(15)
    titulo = "Post #{n+1}"
    Post.create!(titulo: titulo,
                 contenido: content,
                 autor: usuario)
  end
end

def crear_categorias
  
end

def crear_productos
  
end

def crear_fotos
  
end