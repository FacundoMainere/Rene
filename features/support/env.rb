require File.expand_path(File.dirname(__FILE__) + "/../../config/boot")

require 'capybara/cucumber'
require 'rspec/expectations'

##
# You can handle all padrino applications using instead:
#   Padrino.application
Capybara.app = Rene::App.tap { |app|  }
