Pod::Spec.new do |s|
  s.name         = "OpenWeatherKit"
  s.version      = "2.0"
  s.summary      = "Use easly OpenWeatherMap with simple api"
  s.description  = <<-DESC
    OpenWeatherKit is a simple library
  DESC
  s.homepage     = "git@github.com:bourvill/OpenWeatherKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Marinel Maxime" => "maxime.m62@gmail.com" }
  s.social_media_url   = ""
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "git@github.com:bourvill/OpenWeatherKit.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
