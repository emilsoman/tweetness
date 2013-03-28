require 'json'
require 'lib/tweetness/rolling_counter'

module Tweetness
  class RollingCountBolt < RedStorm::SimpleBolt
    on_init do
      # 60 buckets of 10 seconds => Total 10 minutes
      @counter = RollingCounter.new(60, 10) {|hashtag, count| unanchored_emit(hashtag, count)}
    end

    on_receive do |tuple|
      hashtag = tuple.getString(0)
      count = @counter.add(hashtag)
      [hashtag, count]
    end
  end
end
