require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/composite-ruby'

Hoe.plugin :newgem

# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'composite-ruby' do
  self.developer 'Fred George', 'fredgeorge@acm.org'
  self.post_install_message = 'PostInstall.txt'
  self.rubyforge_name       = self.name
  self.extra_deps         = [['rspec','>= 1.2.6']]
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }
