package com.library.util;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;

public class CacheUtil {
	private static CacheManager cf;
	private static Cache cache;
	static {
		try {
			cf = CacheManager.create();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static Cache getCache(){
		if(cache == null){
			cache = cf.getCache("cache");
		}
		return cache;
	}
}
