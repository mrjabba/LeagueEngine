Feature: New League

  So I can create a new league 
  and it is automatically set up with the correct stats (league_stats and stat_types)

  Scenario: New league
    Given I am and admin user
    When I create a new league
    Then I should see the new league
    And it should have the correct stats 