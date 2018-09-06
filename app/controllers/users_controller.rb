class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect 'tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    user = User.new(params[:user])
    if user.save
      #log user in
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup' #if wanted add flash message saying signup failed, please try again
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
    user = User.find_by(:username => params[:user][:username])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/' #if wanted add flash message saying signup failed, please try again
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end


end
