Feature: Project clean

  Background:
    Given I have a leiningen project with dependencies "cljr" in "tmp"
    And I have a clojure-file "tmp/src/cljr/core.clj"
    And I have a clojure-file "tmp/src/cljr/util.clj"
    And I open file "tmp/src/cljr/core.clj"
    And I clear the buffer
    And I insert:
    """
    (ns cljr.core
      (:require [clojure.string :as str]
                [cljr.util :as u]))
    
    (defn join [& xs]
      (u/do-util (first xs))
      (str/join xs))
    """
    And I save the file
    And I open file "tmp/src/cljr/util.clj"
    And I clear the buffer
    And I insert:
    """
    (ns cljr.util)
    
    (defn do-util [x]
      (println x))
    """
    And I save the file
    And I start cider

  Scenario: Invoke project clean action
    When I start an action chain
    And I press "C-! pc"
    And I press "RET"
    And I execute the action chain
    # And I open file "tmp/src/cljr/core.clj"
    And I switch to buffer "core.clj"
    Then I should see:
    """
    (ns cljr.core
      (:require [cljr.util :as u]
                [clojure.string :as str]))
    
    (defn join [& xs]
      (u/do-util (first xs))
      (str/join xs))
    """
