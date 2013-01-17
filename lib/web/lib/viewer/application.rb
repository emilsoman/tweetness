
require 'sinatra'
require 'json'
require 'redis'

module Viewer
  class Application < Sinatra::Base

   set :app_file, __FILE__
   set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
   redis = Redis.new(:host => "localhost", :port => 6379)

   enable :logging

   get '/' do
     erb :index
   end

   get '/data' do
    redis.lpop('rankings')
   end

   get '/stats' do
    tweet_count = redis.get('tweet_count')
    start_time = Time.at redis.get('stats_start_time').to_i
    {tweet_count: tweet_count, start_time: start_time}.to_json
   end

  end
end

