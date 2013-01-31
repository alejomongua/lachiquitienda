Login::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :usuarios

  match "identificate", to: 'sesiones#new'
  match "salir", to: 'sesiones#destroy', via: :delete
  match "registrate", to: 'usuarios#new'
  root to: "paginas_estaticas#inicio"
end