Feature: New League

  So I can create a new league 
  and it is automatically set up with the correct stats (league_stats and stat_types)

  Scenario: New league
    Given I am and admin user
    When I go to new_leagues_path
    And I fill in "league_name" with "My new league"
    And I fill in "league_new_team_attributes__name" with "team name"
	  And I press "Create League"
    Then a league named "My new league" should exist