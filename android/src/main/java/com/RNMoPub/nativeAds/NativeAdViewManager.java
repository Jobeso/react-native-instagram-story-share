package com.RNMoPub.nativeAds;

import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewStub;
import android.widget.RelativeLayout;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.mopub.nativeads.MoPubNative;
import com.mopub.nativeads.MoPubStaticNativeAdRenderer;
import com.mopub.nativeads.NativeAd;
import com.mopub.nativeads.NativeErrorCode;
import com.mopub.nativeads.RequestParameters;
import com.mopub.nativeads.ViewBinder;
import com.RNMoPub.LayoutMap;
import com.RNMoPub.R;

import java.util.EnumSet;
import java.util.Map;

/**
 * Created by Sven Steinert on 23.03.2018.
 */

public class NativeAdViewManager extends SimpleViewManager<View> implements View.OnAttachStateChangeListener, MoPubNative.MoPubNativeNetworkListener, NativeAd.MoPubNativeEventListener
{
    public static final String REACT_CLASS = "NativeAd";
    public static final String FAILURE_EVENT = "onFailure";
    public static final String SUCCESS_EVENT = "onSuccess";
    public static final String IMPRESSION_EVENT = "onImpression";
    public static final String CLICK_EVENT = "onClick";

    private ThemedReactContext themedReactContext;
    private RCTEventEmitter emitter;

    private MoPubNative mopubNative;
    private NativeAd nativeAdHelper;
    private View adView;
    private int layout = -1;

    private String unitId;

    /**
     * This function is called when the View is going to be instantiated.
     * @param context The ThemedReactContext object.
     * @return The manually created View.
     */
    @Override
    public View createViewInstance(ThemedReactContext context)
    {
        themedReactContext = context;
        emitter = context.getJSModule(RCTEventEmitter.class);
        adView = LayoutInflater.from(context).inflate(R.layout.initial, null);
        return adView;
    }

    /**
     * Creates a map of custom events.
     * @return A map of custom events.
     */
    @Override
    public Map<String, Object> getExportedCustomDirectEventTypeConstants() {
        MapBuilder.Builder<String, Object> builder = MapBuilder.builder();
        builder.put(FAILURE_EVENT, MapBuilder.of("registrationName", FAILURE_EVENT));
        builder.put(SUCCESS_EVENT, MapBuilder.of("registrationName", SUCCESS_EVENT));
        builder.put(IMPRESSION_EVENT, MapBuilder.of("registrationName", IMPRESSION_EVENT));
        builder.put(CLICK_EVENT, MapBuilder.of("registrationName", CLICK_EVENT));
        /* For developers
            builder.put(<attribut_name>, MapBuilder.of("registrationName", <attribut_name>));
         */
        return builder.build();
    }

    /**
     * This method is accessible by react-native and reloads the ad.
     */
    @ReactMethod
    public void reload()
    {
        RequestAdInternal();
    }

    /**
     * Requests a new ad.
     */
    private void RequestAdInternal()
    {
        if(unitId == null || layout < 0){
            return;
        }
        mopubNative = new MoPubNative(themedReactContext.getCurrentActivity(), unitId, this);
        mopubNative.registerAdRenderer(new MoPubStaticNativeAdRenderer(new ViewBinder.Builder(layout)
                            .titleId(R.id.native_title)
                            .textId(R.id.native_text)
                            .mainImageId(R.id.native_main_image)
                            .iconImageId(R.id.native_icon_image)
                            .privacyInformationIconImageId(R.id.native_privacy_information_icon_image)
                            .callToActionId(R.id.native_cta)
                            .build()));
        /* For developers
            You can add extra informations like:
            .addExtra("sponsoredtext", R.id.sponsored_text)
            .addExtra("sponsoredimage", R.id.sponsored_image)

            from: https://developers.mopub.com/docs/android/native/
         */

        mopubNative.makeRequest(new RequestParameters.Builder()
                .desiredAssets(EnumSet.of(
                        RequestParameters.NativeAdAsset.TITLE,
                        RequestParameters.NativeAdAsset.TEXT,
                        RequestParameters.NativeAdAsset.MAIN_IMAGE,
                        RequestParameters.NativeAdAsset.ICON_IMAGE,
                        RequestParameters.NativeAdAsset.CALL_TO_ACTION_TEXT))
                .build());
    }

    /**
     * Sets the property "unitId"
     * @param view The view component.
     * @param unitId The ad unit Id.
     */
    @ReactProp(name = "unitId")
    public void setUnitId(View view, @Nullable String unitId) {
        this.unitId = unitId;
        RequestAdInternal();
    }

    /**
     * Sets the property "layout"
     * @param view The view component.
     * @param layout The layout key.
     */
    @ReactProp(name = "layout")
    public void setLayout(View view, @Nullable String layout) {
        this.layout = LayoutMap.Get(layout);
        if(this.layout >= 0){
            ((RelativeLayout)adView).removeAllViews();
            ((RelativeLayout)adView).addView(LayoutInflater.from(themedReactContext).inflate(this.layout, null));
        }else {
            // TODO log error or warning
        }
        RequestAdInternal();
    }

    /**
     * This function is called if the ad was loaded successfully.
     * @param nativeAd The native ad helper.
     */
    @Override
    public void onNativeLoad(NativeAd nativeAd) {
        this.nativeAdHelper = nativeAd;

        SendOnSuccess();
        nativeAd.clear(adView);
        nativeAd.setMoPubNativeEventListener(this);
        nativeAd.renderAdView(adView);
        nativeAd.prepare(adView);
    }

    /**
     * This function is called if the ad was not loaded.
     * @param errorCode The error message.
     */
    @Override
    public void onNativeFail(NativeErrorCode errorCode) {
        SendOnFailure(errorCode.toString());
        Log.w(this.getClass().getSimpleName(), errorCode.toString());
    }

    /**
     * This function is called when the ad view is rendered.
     * @param view The view which holds the ad content.
     */
    @Override
    public void onImpression(View view) {
        SendOnImpression();
    }

    /**
     * This function is called when the ad view was clicked.
     * @param view The view which holds the ad content.
     */
    @Override
    public void onClick(View view) {
        SendOnClick();
    }

    /**
     * Emits a react native event.
     */
    private void SendOnSuccess(){
        WritableMap event = Arguments.createMap();
        emitter.receiveEvent(adView.getId(), SUCCESS_EVENT, event);
    }

    /**
     * Emits a react native event.
     */
    private void SendOnFailure(String message){
        WritableMap event = Arguments.createMap();
        event.putString("message", message);
        emitter.receiveEvent(adView.getId(), FAILURE_EVENT, event);
    }

    /**
     * Emits a react native event.
     */
    private void SendOnImpression(){
        WritableMap event = Arguments.createMap();
        emitter.receiveEvent(adView.getId(), IMPRESSION_EVENT, event);
    }

    /**
     * Emits a react native event.
     */
    private void SendOnClick(){
        WritableMap event = Arguments.createMap();
        emitter.receiveEvent(adView.getId(), CLICK_EVENT, event);
    }

    @Override
    public void onViewAttachedToWindow(View v) { }

    /**
     * This function is called if the view was disposed.
     * Destorys the native ad helper and mopub native.
     * @param v The view which was disposed
     */
    @Override
    public void onViewDetachedFromWindow(View v) {
        if(nativeAdHelper != null){
            nativeAdHelper.destroy();
        }
        if(mopubNative != null){
            mopubNative.destroy();
        }
    }

    /**
     * Returns the name of the react class
     * @return
     */
    @Override
    public String getName() {
        return REACT_CLASS;
    }

}
