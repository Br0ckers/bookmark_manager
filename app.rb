require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :view
  end

  post '/temp' do
  Bookmark.add(params[:URL])
    redirect '/add'
  end

  get '/add' do
    erb :add
  end

  run! if app_file == $0
end
