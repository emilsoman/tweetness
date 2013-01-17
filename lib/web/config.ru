#!/usr/bin/env rackup
LIB_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$:.unshift LIB_PATH

require 'viewer/application'
run Viewer::Application
