Rails.application.routes.draw do
  get 'posts/new'
  post 'posts/create'
  #get 'accounts/login'
  #get 'accounts/signup'
  root 'home#index'
  get 'home/index'



get 'login' => 'accounts#login'
get 'signup' => 'accounts#signup'
post 'create_account' => 'accounts#create_account'
post 'create_login' => 'accounts#create_login'
delete 'logout' => 'accounts#logout'
get 'account_active' => 'accounts#account_active'
get 'update_active/:account_id' => 'accounts#update_active'

get 'posts/create_thumb/:post_id/:is_thumb' => 'posts#create_thumb'
get 'posts/show_posts/:post_id' => 'posts#show_posts'
post 'posts/create_comment' => 'posts#create_comment'
get 'posts/delete_comment/:comment_id' => 'posts#delete_comment'
get 'posts/show_replys/:comment_id/:point' => 'posts#show_replys'


# now you take your first step 2021/12/27 22:24
post 'posts/show_posts/posts/create_comment' => 'posts#create_comment'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
