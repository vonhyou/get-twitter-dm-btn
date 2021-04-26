require 'sinatra'

get '/' do
  erb :index
end

post '/' do
  unless params[:id].empty? or params[:content].empty?
    baselink = "https://twitter.com/messages/compose?text"
    @permlink = "#{baselink}=#{URI.encode params[:content]}&recipient_id=#{params[:id]}"
  end
  erb :index
end
