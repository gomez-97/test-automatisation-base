package com.pichincha.shared.caching;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;

public class LocalStorage {
  private static final Cache<String, Object> cache = CacheBuilder.newBuilder().build();

  private LocalStorage() {}

  public static void put(String key, Object value) {
    cache.put(key, value);
  }

  public static Object get(String key) {
    return cache.getIfPresent(key);
  }

  public static void clear() {
    cache.invalidateAll();
  }
}
