package com.pichincha.core.runner;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

class CoreRunnerTest {

  @Test
  void runAllFeaturesInParallel() {
    Results results = Runner.path("classpath:com/pichincha").outputCucumberJson(true).parallel(5);

    assertEquals(0, results.getFailCount(), results.getErrorMessages());
  }
}
