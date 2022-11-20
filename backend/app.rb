require 'sinatra'
require_relative 'producer'

configure do
  set :bind, '0.0.0.0'
end

before do
  content_type :json
end

get '/' do
  payload = { "message": "ok" }.to_json
  producer = Producer.new
  producer.send payload
  producer.close
  'OK'
end
