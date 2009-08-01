require 'rubygems'
require 'spec'
require 'spec/mocks'

root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
Dir.glob(File.join(root, 'lib', '*.rb')).each { |rb| require rb }  
Dir.glob(File.join(root, 'spec', 'helpers', '*.rb')).each { |rb| require rb }  
