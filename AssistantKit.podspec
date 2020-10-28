Pod::Spec.new do |s|
  s.name             = 'AssistantKit'
  s.version          = '0.7.1'
  s.summary          = 'Easy way to detect and work with  device environments written in Swift'

  s.description      = <<-DESC
Will be useful to:
- Detect device types
- Detect screen properties
- Detect iOS versions
- Detect battery states
DESC

  s.homepage         = 'https://github.com/anatoliyv/AssistantKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anatoliy Voropay' => 'anatoliy.voropay@gmail.com' }
  s.source           = { :git => 'https://github.com/anatoliyv/AssistantKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/anatoliy_v'
  s.ios.deployment_target = '9.0'
  s.source_files = 'AssistantKit/Classes/**/*'
  s.frameworks = 'UIKit'
end
