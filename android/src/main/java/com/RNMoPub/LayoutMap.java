package com.RNMoPub;

import java.util.HashMap;

public class LayoutMap {
    private static HashMap<String, Integer> map = new HashMap<>();

    static {
        map.put("MOPUB_NATIVEAD_BIG", R.layout.native_ad_big);
        map.put("MOPUB_NATIVEAD_BIG_DARK", R.layout.native_ad_big_dark);
        map.put("MOPUB_NATIVEAD_MEDIUM", R.layout.native_ad_medium);
        map.put("MOPUB_NATIVEAD_MEDIUM_DARK", R.layout.native_ad_medium_dark);
        map.put("MOPUB_NATIVEAD_SMALL", R.layout.native_ad_small);
        map.put("MOPUB_NATIVEAD_SMALL_DARK", R.layout.native_ad_small_dark);
    }

    public static int Get(String key) {
        if (map.containsKey(key)) {
            return map.get(key);
        }
        return -1;
    }
}
