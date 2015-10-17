Gem::Specification.new do |spec|
  spec.name         = 'wrkflo'
  spec.version      = '0.0.2'
  spec.date         = Date.today.strftime('%F')
  spec.summary      = "Work on things!"
  spec.authors      = ["Jon Egeland"]
  spec.email        = 'audiobahn404@gmail.com'
  spec.files        += Dir['lib/wrkflo/*'] + Dir['lib/wrkflo/**/*']
  # spec.homepage     = 'http://rubygems.org/gems/wrkflo'
  spec.license      = 'MIT'

  spec.executables << 'wrkflo'
end
