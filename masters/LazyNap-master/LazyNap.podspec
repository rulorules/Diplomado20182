Pod::Spec.new do |s|
  s.name             = 'LazyNap'
  s.version          = '0.0.2'
  s.summary          = 'Network services layer based in RESTFUL conventions'
  s.description      = <<-DESC
  Network services layer designed to match RESTFUL endpoints and based on api conventions allowing to create a CRUD service per endpoint with minimal effort.
                       DESC
  s.homepage         = 'https://github.com/3zcurdia/LazyNap'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Luis Ezcurdia' => 'ing.ezcurdia@gmail.com' }
  s.source           = { git: 'https://github.com/3zcurdia/LazyNap.git', tag: s.version.to_s }

  s.swift_version = '4.0'
  s.ios.deployment_target = '8.0'

  s.source_files = 'LazyNap/Classes/**/*'

  # s.resource_bundles = {
  #   'LazyNap' => ['LazyNap/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
