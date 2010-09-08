Feature: Clone League

  So that when a new season starts I can clone the previous seasons league and go from there

  Scenario: Clone league and set back to zero state
    Given I am and admin user
    And a league exists
    When I clone the league
    Then I should see a clone of the existing league