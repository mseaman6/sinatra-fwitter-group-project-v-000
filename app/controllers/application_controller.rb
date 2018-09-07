require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
      #!!session[:user_id]
    end

    def current_user
      user ||= User.find(session[:user_id])
      binding.pry
    end
  end

end
