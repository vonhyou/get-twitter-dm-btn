require 'sinatra'
require 'net/http'

def handle_to_id(handle)
  get_id_uri = URI 'https://tweeterid.com/ajax.php'

  res = Net::HTTP.post_form(get_id_uri, 'input': handle)
  res.body.to_s
end

get '/' do
  erb :index
end

post '/' do
  unless params[:handle].empty? or params[:content].empty?
    baselink = "https://twitter.com/messages/compose?text"
    greetings = URI.encode params[:content]
    twitter_id = handle_to_id params[:handle]
    @permlink = "#{baselink}=#{greetings}&recipient_id=#{twitter_id}"
  end
  erb :index
end
