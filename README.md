### ANDROID ###

+ Benötigte Zugriffe in AndroidManifest.xml eintragen:

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <!-- Optional permissions. Will pass Lat/Lon values when available. Choose either Coarse or Fine -->
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>

    <!-- Optional permissions. Used for MRAID 2.0 storePicture ads -->
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
	
+ Wichtige Activities in AndroidManifest.xml eintragen:

	<activity android:name="com.mopub.mobileads.MoPubActivity"
		android:configChanges="keyboardHidden|orientation|screenSize"/>
	<activity android:name="com.mopub.mobileads.MraidActivity"
		android:configChanges="keyboardHidden|orientation|screenSize"/>
	<activity android:name="com.mopub.common.MoPubBrowser"
		android:configChanges="keyboardHidden|orientation|screenSize"/>
	<activity android:name="com.mopub.mobileads.MraidVideoPlayerActivity"
		android:configChanges="keyboardHidden|orientation|screenSize"/>
	<meta-data android:name="com.google.android.gms.version"
		android:value="@integer/google_play_services_version" />
		
+ Gradle Dependencies in build.gradle (dependencies) eintragen:

    compile "com.facebook.react:react-native:+"  // From node_modules
    implementation 'com.google.android.gms:play-services-ads:11.4.0'
    implementation 'com.google.android.gms:play-services-base:11.4.0'
    compile('com.mopub:mopub-sdk:4.7.1@aar') {
        transitive = true
    }
	
+ Native Modul Name ändern (Im JS Modul auch anpassen)
	com.RNMoPub.nativeAds -> NativeAdViewManager [Zeile 38]:
		public static final String REACT_CLASS = "NativeTellAd";
		
+ Layout für Ad ändern:
	com.RNMoPub.nativeAds -> NativeAdViewManager [Zeile 38]:
		public static final int LAYOUT = R.layout.native_ad;
		
+ Eigene Attribut Events hinzufügen:
	com.RNMoPub.nativeAds -> NativeAdViewManager [Zeile 76]:
		builder.put(<attribut_name>, MapBuilder.of("registrationName", <attribut_name>));

+ Layout für Ad mit ViewBinder anpassen:
	com.RNMoPub.nativeAds -> NativeAdViewManager [Zeile 99]:

+ Event aus Attribut ausführen
	WritableMap event = Arguments.createMap();
	emitter.receiveEvent(adView.getId(), <attribut_name>, event);
	(Siehe com.RNMoPub.nativeAds -> NativeAdViewManager [Zeile 186])
	
	
	
### REACT NATIVE (JS) ###

Javascript Modul:
	- app/TellAdModule.js
	Wichtig zu beachten:
		Beim Ändern des Modulnamen im Android Teil muss hier ↓ auch der Name geändert werden.
		Zeile 4: const TellAd = requireNativeComponent('NativeTellAd', NativeTellAdView)

TellAd benutzen mittels: import TellAd from './app/TellAdModule.js'

Alles Weitere wird in App.js gezeigt.
