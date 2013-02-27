FactoryGirl.define do
  factory :usuario do
    sequence(:nombre)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :post do
    sequence(:titulo) { |n| "Titulo #{n}" }
    sequence(:contenido)  {|n| "#{LoremIpsum.generate}#{n}" }
    autor admin
  end
  
  factory :categoria do
    sequence(:nombre) { |n| "Categoria #{n}" }
  end

  factory :producto do
    sequence(:nombre) { |n| "Producto #{n}"}
    sequence(:descripcion) { |n| "Lorem Ipsum #{n}"}
    categoria
    
  end
end