package com.RNMoPub;

import com.RNMoPub.R;

import java.util.HashMap;

/**
 * Created by Sven Steinert on 31.03.2018.
 */

public class LayoutMap
{
    private static HashMap<String, Integer> map = new HashMap<>();

    static{
        map.put("SMALL", R.layout.native_ad);
        map.put("BIG", R.layout.native_ad_big);
    }

    public static int Get(String key){
        if(map.containsKey(key)){
            return map.get(key);
        }
        return -1;
    }
}
