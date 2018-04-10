import {NativeModules, NativeEventEmitter} from 'react-native';

import type EmitterSubscription from 'EmitterSubscription';

const MoPubInterstitial = NativeModules.RNMoPubInterstitial;
const emitter = new NativeEventEmitter(MoPubInterstitial);

module.exports = {
  initialize: (adUnitId: string) => MoPubInterstitial.initialize(adUnitId),
  setTesting: (testing: boolean) => MoPubInterstitial.setTesting(testing),
  setKeywords: (keywords: string) => MoPubInterstitial.setKeywords(keywords),
  isReady: (): Promise => MoPubInterstitial.isReady(),
  load: () => MoPubInterstitial.load(),
  show: () => MoPubInterstitial.show(),
  showWhenReady: () => {
    MoPubInterstitial.isReady()
      .then(ready => {
        if (ready){
          MoPubInterstitial.show();
        }
        else {
          const subscription = emitter.addListener('onLoaded', () => {
            emitter.removeSubscription(subscription);
            MoPubInterstitial.show();
          });
          MoPubInterstitial.load();
        }
      });
  },
  addEventListener: (eventType: string, listener: Function): EmitterSubscription => emitter.addListener(eventType, listener),
  removeSubscription: (subscription: EmitterSubscription) => emitter.removeSubscription(subscription),
  removeAllListeners: (eventType: string) => emitter.removeAllListeners(eventType)
};