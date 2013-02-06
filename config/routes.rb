Login::Application.routes.draw do
  match 'auth/:provider/callback', to: 'sesiones#oauth'
  match 'auth/failure', to: redirect('/')

  resources :sesiones, only: [:new, :create, :destroy]
  resources :usuarios

  match "identificate", to: 'sesiones#new'
  match "salir", to: 'sesiones#destroy', via: :delete
  match "registrate", to: 'usuarios#new'
  match "agradecimientos", to: 'paginas_estaticas#agradecimientos'
  match "politica_de_privacidad", to: 'paginas_estaticas#politica_de_privacidad'
  match "olvide_contrasena", to: "usuarios#generar_tokens", via: :post
  match "olvide_contrasena", to: "usuarios#olvide_contrasena", via: :get
  root to: "paginas_estaticas#inicio"
end