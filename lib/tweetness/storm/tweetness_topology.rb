require 'red_storm'

require 'lib/tweetness/storm/twitter_stream_spout'
require 'lib/tweetness/storm/extract_message_bolt'
require 'lib/tweetness/storm/extract_hashtags_bolt'
require 'lib/tweetness/storm/rolling_count_bolt'
require 'lib/tweetness/storm/rank_bolt'
require 'lib/tweetness/storm/merge_bolt'

module Tweetness
 
  class TweetnessTopology < RedStorm::SimpleTopology
    spout TwitterStreamSpout do
      output_fields :tweet
    end
        
    bolt ExtractMessageBolt, :parallelism => 3 do
      source TwitterStreamSpout, :shuffle
      output_fields :message
    end

    bolt ExtractHashtagsBolt, :parallelism => 3 do
      source ExtractMessageBolt, :shuffle
      output_fields :hashtag
    end

    bolt RollingCountBolt, :parallelism => 3 do
      source ExtractHashtagsBolt, :fields => ["hashtag"]
      output_fields :hashtag, :count
    end

    bolt RankBolt, :parallelism => 3 do
      source RollingCountBolt, :fields => ["hashtag"]
      output_fields :json_rankings
    end

    bolt MergeBolt, :parallelism => 1 do
      source RankBolt, :global
      output_fields :json_rankings
    end

    configure do |env|
      debug false
      case env
      when :local
        max_task_parallelism 10
      when :cluster
        num_workers 20
        max_spout_pending 5000
      end
    end
  end
end
