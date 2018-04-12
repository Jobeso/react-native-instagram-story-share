package com.RNMoPub;

import java.util.HashMap;

public class LayoutMap {
    private static HashMap<String, Integer> map = new HashMap<>();

    static {
        map.put("BIG", R.layout.native_ad_big);
        map.put("BIG_DARK", R.layout.native_ad_big_dark);
        map.put("MEDIUM", R.layout.native_ad_medium);
        map.put("SMALL", R.layout.native_ad_small);
    }

    public static int Get(String key) {
        if (map.containsKey(key)) {
            return map.get(key);
        }
        return -1;
    }
}
