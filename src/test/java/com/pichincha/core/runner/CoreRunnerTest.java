package com.pichincha.core.runner;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.pichincha.shared.caching.LocalStorage;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Test;

class CoreRunnerTest {

  @Test
  void runAllFeaturesInParallel() {
    Results results = Runner.path("classpath:com/pichincha").outputCucumberJson(true).parallel(1);

    assertEquals(0, results.getFailCount(), results.getErrorMessages());
  }

  @AfterAll
  static void cleanUp() {
    LocalStorage.clear();
  }
}
