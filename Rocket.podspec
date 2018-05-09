
Pod::Spec.new do |s|

  s.name             = 'Rocket'
  s.version          = '1.0.0'
  s.summary          = 'Lightweight Swift logging library.'
  s.description      = <<-DESC
    Lightweight Swift loggin library.
    DESC

  s.homepage         = 'https://github.com/mitchtreece/Rocket'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mitch Treece' => 'mitchtreece@me.com' }
  s.source           = { :git => 'https://github.com/mitchtreece/Rocket.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MitchTreece'

  s.platform = :ios, "10.0"
  s.ios.public_header_files = 'Rocket/Classes/**/*.h'
  s.source_files = 'Rocket/Classes/**/*'

end
