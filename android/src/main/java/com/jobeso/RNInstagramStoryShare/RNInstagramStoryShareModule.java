package com.jobeso.RNInstagramStoryShare;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.pm.ResolveInfo;
import android.os.Build;
import android.os.Bundle;
import android.view.MenuItem;
import android.annotation.SuppressLint;
import android.view.View;
import android.view.WindowManager;
import android.view.KeyCharacterMap;
import android.util.DisplayMetrics;
import android.view.KeyEvent;
import android.view.ViewConfiguration;
import android.view.Display;
import android.content.Context;
import android.util.Log;
import android.content.Intent;
import android.content.ActivityNotFoundException;
import android.net.Uri;
import android.support.annotation.Nullable;

import java.io.File;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.UiThreadUtil;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;

import okhttp3.MediaType;

public class RNInstagramStoryShareModule extends ReactContextBaseJavaModule {

    ReactApplicationContext reactContext;

    public static final String NOT_INSTALLED = "Not installed";
    public static final String INTERNAL_ERROR = "Data conversion failed";
    public static final String NO_BASE64_IMAGE = "No base64 image";
    public static final String INVALID_PARAMETER = "Invalid parameter";
    private static final String MEDIA_TYPE_JPEG = "image/*";

    public RNInstagramStoryShareModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "RNInstagramStoryShare";
    }

    @ReactMethod
    public void share(ReadableMap options, @Nullable Callback failureCallback, @Nullable Callback successCallback) {
      try {
        // Define image asset URI and attribution link URL
          File imageFileToShare = new File("/storage/emulated/0/DCIM/Camera/IMG_20180530_212925.jpg");
        Uri backgroundAssetUri = Uri.fromFile(imageFileToShare);//options.getString("backgroundImage"));
        String attributionLinkUrl = options.getString("deeplinkUrl");


        // Instantiate implicit intent with ADD_TO_STORY action,
        // background asset, and attribution link
        Intent intent = new Intent("com.instagram.share.ADD_TO_STORY");
        intent.setDataAndType(backgroundAssetUri, MEDIA_TYPE_PNG);
        intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        intent.putExtra("content_url", attributionLinkUrl);

        // Instantiate activity and verify it will resolve implicit intent
        Activity activity = getCurrentActivity();
        ResolveInfo should = activity.getPackageManager().resolveActivity(intent, 0);
        if (should != null) {
          activity.startActivityForResult(intent, 0);
          successCallback.invoke("OK");
        } else {
          successCallback.invoke("OK, but not opened");
        }




      } catch(ActivityNotFoundException ex) {
          System.out.println("ERROR");
          System.out.println(ex.getMessage());
          failureCallback.invoke(ex);
      }
    }

}
