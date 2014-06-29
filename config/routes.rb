Rails.application.routes.draw do
  get 'mechanize/go'

  get 'words/index'

  get 'articles/index'

  get 'counts/index'

  get 'pages/index'

  root 'pages#index'

  get '/search', to: 'pages#index' 
  get 'words/new', to: 'words#new'

#           Prefix Verb URI Pattern               Controller#Action
#    words_index GET  /words/index(.:format)    words#index
# articles_index GET  /articles/index(.:format) articles#index
#   counts_index GET  /counts/index(.:format)   counts#index
#    pages_index GET  /pages/index(.:format)    pages#index
#           root GET  /                         pages#index
#         search GET  /search(.:format)         pages#index

end
