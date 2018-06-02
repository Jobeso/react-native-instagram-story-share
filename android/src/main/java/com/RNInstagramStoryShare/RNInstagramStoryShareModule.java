<package com.RNInstagramStoryShare;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.Callback;

import android.app.Activity;
import android.content.Intent;
import android.content.ActivityNotFoundException;
import android.net.Uri;
import android.support.annotation.Nullable;

import java.util.Map;
import java.util.HashMap;

import okhttp3.MediaType;

public class RNInstagramStoryShareModule extends ReactContextBaseJavaModule {

  public static final String NOT_INSTALLED = "Not installed";
  public static final String INTERNAL_ERROR = "Data conversion failed";
  public static final String NO_BASE64_IMAGE = "No base64 image";
  public static final String INVALID_PARAMETER = "Invalid parameter";
  private  static final String MEDIA_TYPE_JPEG = "image/*";

  public RNInstagramStoryShareModule(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  public String getName() {
    return "RNInstagramStoryShare";
  }

  @Override
  public Map<String, Object> getConstants() {
    final Map<String, Object> constants = new HashMap<>();
    constants.put(NOT_INSTALLED, NOT_INSTALLED);
    constants.put(INTERNAL_ERROR, INTERNAL_ERROR);
    constants.put(NO_BASE64_IMAGE, NO_BASE64_IMAGE);
    constants.put(INVALID_PARAMETER, INVALID_PARAMETER);
    return constants;
  }

  @ReactMethod
  public void share(ReadableMap options, @Nullable Callback failureCallback, @Nullable Callback successCallback) {
    try {
      // Define image asset URI and attribution link URL
      Uri backgroundAssetUri = Uri.parse(options.getString("backgroundImage"));
      String attributionLinkUrl = options.getString("deeplinkUrl");


      // Instantiate implicit intent with ADD_TO_STORY action,
      // background asset, and attribution link
      Intent intent = new Intent("com.instagram.share.ADD_TO_STORY");
      intent.setDataAndType(backgroundAssetUri, MEDIA_TYPE_JPEG);
      intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
      intent.putExtra("content_url", attributionLinkUrl);

      // Instantiate activity and verify it will resolve implicit intent
      Activity activity = this.getCurrentActivity();
      if (activity.getPackageManager().resolveActivity(intent, 0) != null) {
        activity.startActivityForResult(intent, 0);
      }
      successCallback.invoke("OK");
    } catch(ActivityNotFoundException ex) {
        System.out.println("ERROR");
        System.out.println(ex.getMessage());
        failureCallback.invoke(ex);
    }
  }

 
}
>
