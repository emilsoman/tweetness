require 'json'

module Tweetness
  class ExtractMessageBolt < RedStorm::SimpleBolt

    on_receive do |tuple| 
      json = tuple.getString(0)
      JSON.parse(json)["text"]
    end
  end
end
