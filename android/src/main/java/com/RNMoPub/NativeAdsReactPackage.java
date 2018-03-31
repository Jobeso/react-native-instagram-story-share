package com.RNMoPub;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;
import com.RNMoPub.nativeAds.NativeAdViewManager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class NativeAdsReactPackage implements ReactPackage {

  @Override
  public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
    return new ArrayList<>();
  }

  @Override
  public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
          return Arrays.<ViewManager>asList(
            new NativeAdViewManager()
    );
  }
}
