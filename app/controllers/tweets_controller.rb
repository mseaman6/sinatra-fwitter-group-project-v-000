class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(:content => params[:content])
    @tweet.user_id = session[:user_id]
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      #if @tweet = current_user.tweets.find_by(params[:id])
      @tweet = Tweet.find(params[:id])
      if current_user == @tweet.user_id
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets/:id'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(:content => params[:content])
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/:user_id/tweets' do
    if logged_in?
      @tweets = current_user.tweets
      erb :'users/show'
    else
      redirect '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user == @tweet.user_id
        @tweet = Tweet.destroy(params[:id])
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
