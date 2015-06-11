Feature: User Sign In

  As a registered user
  I want to sign in to my account
  So that I can perform restricted actions

  Background:

  Scenario: Happy Path - Successful Sign In
    Given I am an existing registered user
    When I visit the Sign In page
    And I fill in the Sign In form correctly
    And I press "Sign In"
    Then I am redirected to the Home page
    And I can see a Notice Flash
    And I can see correct Username on the page

  Scenario: Sad Path - Unsuccessful Sign In - Invalid Data
    When I visit the Sign In page
    And I fill in the Sign In form with invalid data
    And I press "Sign In"
    Then I am redirected to the Sign In page
    And I can see an Error Flash
    And I can see Sign In link

  Scenario: Sad Path - Unsuccessful Sign In - Non Existent User
    When I visit the Sign In page
    And I fill in the Sign In form with non-existent user
    And I press "Sign In"
    Then I am redirected to the Sign In page
    And I can see an Error Flash
    And I can see Sign In link