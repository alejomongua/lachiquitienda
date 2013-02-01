Login::Application.routes.draw do
  resources :sesiones, only: [:new, :create, :destroy]
  resources :usuarios

  match "identificate", to: 'sesiones#new'
  match "salir", to: 'sesiones#destroy', via: :delete
  match "registrate", to: 'usuarios#new'
  match "agradecimientos", to: 'paginas_estaticas#agradecimientos'
  match "politica_de_privacidad", to: 'paginas_estaticas#politica_de_privacidad'
  root to: "paginas_estaticas#inicio"
end