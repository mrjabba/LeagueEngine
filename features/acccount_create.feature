Feature: create account

  An anonymous user can create and account

  Scenario: create account
    Given I am on new_account_path
    When I select "Soccer" from "account_sport_id"
    And I fill in the following:
         | account_name   | newAccount     |
         | username       | user           |
         | password       | somepassword   |
         | email          | me@gmail.com   |
    And I press "Create Account"
    Then I should see "Account Created"