class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect 'tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
    if user.save
      #log user in
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
      #if wanted add flash message saying signup failed, please try again
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/'
      #if wanted add flash message saying signup failed, please try again
    end
  end

  get "/users/#{user.slug}" do
    binding.pry
    if logged_in?
      @tweets = current_user.tweets
      erb :'users/show'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end


end
