# -*- encoding: utf-8 -*-

require File.expand_path('../lib/taskr/version', __FILE__)

Gem::Specification.new do |gem|

  gem.version = Taskr::VERSION

  gem.name = 'taskr-wannabe'

  gem.authors = ['Filip Kostovski']
  
  gem.email = ['github.sirfilip@gmail.com']
  
  gem.description = 'Just a dummy task runner dsl'
  
  gem.summary = 'Run your tasks everyday'

  gem.homepage = 'https://github.com/sirfilip/blogcode/tree/master/taskr'

  gem.license = 'MIT'
  
  gem.files = Dir['lib/**/*']

  gem.executables = ['taskr']

  gem.test_files = Dir['spec/**/*']

end
