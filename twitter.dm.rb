require 'sinatra'
require 'net/http'

def handle_to_id(handle)
  get_id_uri = URI 'https://tweeterid.com/ajax.php'

  res = Net::HTTP.post_form(get_id_uri, 'input': handle)
  res.body.to_s
end

def make_permlink(content, handle)
  baselink = "https://twitter.com/messages/compose?text"
  greetings = URI.encode content
  twitter_id = handle_to_id handle
  "#{baselink}=#{greetings}&recipient_id=#{twitter_id}"
end

get '/' do
  erb :index
end

post '/' do
  unless params[:handle].empty? or params[:content].empty?
    @permlink = make_permlink params[:content], params[:handle]
  end
  erb :index
end
