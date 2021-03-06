Login::Application.routes.draw do
  resources :items, ecxept: [:show, :edit]
  resources :pedidos, ecxept: [:destroy]

  resources :productos do
    resources :fotos
  end    
  resources :categorias do
    resources :opciones
    resources :fotos
    member { post :campos }
  end
  resources :posts

  get "etiquetas/index"

  match 'auth/:provider/callback', to: 'sesiones#oauth'
  match 'auth/failure', to: redirect('/')

  resources :sesiones, only: [:new, :create, :destroy]
  resources :usuarios

  match "identificate", to: 'sesiones#new'
  match "salir", to: 'sesiones#destroy', via: :delete
  match "registrate", to: 'usuarios#new'
  match "agradecimientos", to: 'paginas_estaticas#agradecimientos'
  match "politica_de_privacidad", to: 'paginas_estaticas#politica_de_privacidad'
  match "pedidos_y_devoluciones", to: 'paginas_estaticas#pedidos_devoluciones'
  match "condiciones_del_servicio", to: 'paginas_estaticas#condiciones'
  match "acerca_de_nosotros", to: 'paginas_estaticas#acerca_de'
  match "olvide_contrasena", to: "usuarios#generar_tokens", via: :post
  match "olvide_contrasena", to: "usuarios#olvide_contrasena", via: :get
  root to: "paginas_estaticas#inicio"
end