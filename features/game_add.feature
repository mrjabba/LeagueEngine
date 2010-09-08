Feature: Add Game

  So that a user can add a game and update the league

  Scenario: Add Game
    Given I am and admin user
    And a league exists
    And has teams in it
    When I add a game
    Then I should the new game
    And the league should update