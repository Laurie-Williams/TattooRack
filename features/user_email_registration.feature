Feature: User Email Registration
  As a user
  I want to create a user account with an Email and Password
  So I can access it on the site

  Background:
    Given I visit the User Registration page

  Scenario: Happy Path - Seccessful Sign Up
    And I fill in the User Registration form correctly
    And I click Register
    Then I am redirected to the User Edit page
    And the Username field contains correct Username
    When I click my User Profile Link
    Then I am redirected to my User Profile page
    And I can see my Username on the page
    And I can see Sign Out Link

  Scenario: Sad Path - Unsuccessful Sign Up
    And I fill in the User Registration form incorrectly
    And I click Register
    Then I am redirected back to the User Registration Page
    And I can see an Error Notification
    And I can see Sign In link