require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/transmission-connector'

Hoe.plugin :newgem

$hoe = Hoe.spec 'transmission-connector' do
  self.developer 'Mattis Stordalen Flister', 'mattis.stordalen.flister@gmail.com'
  self.post_install_message = 'PostInstall.txt'
  self.rubyforge_name       = self.name
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }