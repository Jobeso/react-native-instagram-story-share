package com.testapp;

import com.testapp.R;

import java.util.HashMap;

/**
 * Created by Sven Steinert on 31.03.2018.
 */

public class LayoutMap
{
    private static HashMap<String, Integer> map = new HashMap<>();

    static{
        map.put("small", R.layout.native_ad);
        //map.put("big", R.layout.big_native_ad);
    }

    public static int Get(String key){
        if(map.containsKey(key)){
            return map.get(key);
        }
        return -1;
    }
}
