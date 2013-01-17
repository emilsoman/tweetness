# Tweetness

Tweetness, a POC made around Storm and Twitter. It counts the popular hashtags in realtime using [RedStorm](https://github.com/colinsurprenant/redstorm)/[Storm](https://github.com/nathanmarz/storm).

Resources :

- [slideshare presentation](http://www.slideshare.net/colinsurprenant/twitter-big-data) about Twitter Big Data and Tweetness.
- Tweitgeist [http://tweitgeist.colinsurprenant.com/](http://tweitgeist.colinsurprenant.com/)
- [Redstorm](https://github.com/colinsurprenant/redstorm)

There are three components that you need to run:

- The Twitter Reader which uses `twitter-stream` gem to read tweets from the Twitter streaming API and pushes tweets to Redis
- The storm topology run using JRuby which picks tweets from Redis, executes the counting algorithm in parallel, and pushes the top 10 ranks back to Redis
- The UI which is a Sinatra app which reads the ranks from Redis and displays it on the browser.

## Installation

- [Redis](http://redis.io/) is required
- [RVM](http://rvm.io/) for switching to JRuby for starting the RedStorm topology

The required gems for the three components are installed based on the platform which runs `bundle install`. Read the
`Gemfile` to see how it works.

### Redstorm backend

- requires JRuby 1.6.x

- set JRuby in 1.9 mode. Run this in the shell :

  ``` sh
  export JRUBY_OPTS=--1.9
  ```

- install the RedStorm gem using bundler with the supplied Gemfile.

  ``` sh
  $ bundle install
  ```

- run RedStorm installation

  ``` sh
  $ bundle exec redstorm install
  ```

- package the topology required gems

  ``` sh
  $ bundle exec redstorm bundle topology
  ```

- if you plan on running the topology on a cluster, package the topology jar

  ``` sh
  bundle exec redstorm jar lib/tweetness/
  ```

-To run the topology locally, run:

``` sh
$ bundle exec redstorm local lib/tweetness/storm/tweetness_topology.rb
```

### Twitter Reader

- requires Ruby 1.9.x

- install required gems using bundler with the supplied Gemfile

  ``` sh
  $ bundle install
  ```
- edit `config/twitter_reader.rb` to add your credentials

``` sh
$ ruby lib/tweetness/twitter/twitter_reader.rb
```

### Viewer

If you ran `bundle install` for the Twitter Reader component, there's nothing to do here.
It would install sinatra.

Run the sinatra app and point your browser at localhost:9292
``` sh
$ rackup lib/web/config.ru
```


## Usage

- Redis should be up and running on localhost
- All three components should be running concurrently if you want to see the output on the webpage .
