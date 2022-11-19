require 'sinatra'

configure do
  set :bind, '0.0.0.0'
end

before do
  content_type :json
end

get '/' do
  { "message": "ok" }.to_json
end
