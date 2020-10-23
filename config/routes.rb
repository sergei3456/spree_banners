Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    resources :banners

    # constraints(Spree::Banner) do
    #   get '/(*path)', to: 'banners#show', as: 'static'
    # end
  end
end
