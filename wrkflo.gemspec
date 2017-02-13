Gem::Specification.new do |spec|
  spec.platform               = Gem::Platform::RUBY
  spec.name                   = 'wrkflo'
  spec.version                = '0.0.4a'
  spec.date                   = Date.today.strftime('%F')
  spec.summary                = 'Get working on things faster with predefined wrkflos.'

  spec.required_ruby_version  = '>= 2.2.0'

  spec.author                 = 'Jon Egeland'
  spec.email                  = 'jonegeland@gmail.com'

  spec.files                  += Dir['lib/wrkflo/*'] + Dir['lib/wrkflo/**/*']
  spec.homepage               = 'http://github.com/faultyserver/wrkflo'
  spec.license                = 'MIT'

  spec.executables            << 'wrkflo'
end
