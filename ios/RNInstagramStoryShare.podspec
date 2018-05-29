require 'json'
package = JSON.parse(File.read('../package.json'))

Pod::Spec.new do |s|
  s.name                = "RNInstagramStoryShare"
  s.version             = package["version"]
  s.summary             = package["description"]
  s.description         = <<-DESC
                            A Instagram Story Share implementation for React Native, supporting iOS & Android.
                          DESC
  s.homepage            = "http://callosum-sw.de/"
  s.license             = package['license']
  s.authors             = "Callosum Software GmbH"
  s.source              = { :git => "https://gitlab.com/Tellonym/react-native-instagram-story-share.git"}
  s.source_files        = 'RNInstagramStoryShare/**/*.{h,m}'
  s.resources           = 'RNInstagramStoryShare/**/*.xib'
  s.platform            = :ios, "8.0"

  s.dependency          'React'
end
