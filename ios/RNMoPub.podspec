require 'json'
package = JSON.parse(File.read('../package.json'))

Pod::Spec.new do |s|
  s.name                = "RNMoPub"
  s.version             = package["version"]
  s.summary             = package["description"]
  s.description         = <<-DESC
                            A MoPub implementation for React Native, supporting iOS & Android.
                          DESC
  s.homepage            = "http://callosum-sw.de/"
  s.license             = package['license']
  s.authors             = "Callosum Software GmbH"
  s.source              = { :git => "https://gitlab.com/Tellonym/react-native-mopub.git"}
  s.source_files        = 'RNMoPub/**/*.{h,m}'
  s.resources           = 'RNMoPub/**/*.xib'
  s.platform            = :ios, "8.0"

  s.dependency          'React'
  s.dependency          'mopub-ios-sdk'
  s.dependency          'MoPub-FacebookAudienceNetwork-Adapters'
  s.dependency          'MoPub-AdMob-Adapters'
  s.dependency          'MoPub-Flurry-Adapters'
end
