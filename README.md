# React Native Instagram Story Share #

## Installation ##


+ execute `yarn add react-native-instagram-share`

### iOS ###

+ add `instagram-stories` to the `LSApplicationQueriesSchemes` key in your app's Info.plist.

```
...
<key>LSApplicationQueriesSchemes</key>
<array>
	...
	<string>instagram-stories</string>
</array>
...
```
+ add `RNInstagramStoryShare` to your Podfile.

```
platform :ios, '8.0'

target 'Tellonym' do
  # use_frameworks!
	...
	pod 'RNInstagramStoryShare', :path => '../node_modules/react-native-instagram-story-share/ios'
	...
end
```

+ In your ios folder run `pod install`

### Android ###

+ run `yarn link react-native-instagram-share`


## Usage ##

```javascript
import RNInstagramStoryShare from 'react-native-instagram-story-share'

RNInstagramStoryShare.share({
	backgroundImage: 'data:image/png;base64, ...',
	deeplinkUrl: 'https://github.com/',
})
.then(() => console.log('SUCCESS'))
.catch(e => console.log('ERROR', e))
```
