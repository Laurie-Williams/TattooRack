Feature: User Email Registration
  As a user
  I want to create a user account with an Email and Password
  So I can access it on the site

  Background:
    Given I visit the User Registration page

  Scenario: Happy Path - Seccessful Sign Up
    And I fill in the User Registration form correctly
    And I click Register
    Then I am redirected to the Home page
    And I can see email confirmation notification
    And "john89@example.com" should receive an email with subject "Confirmation instructions"
    When I open the email with subject "Confirmation instructions"
    And I follow "Confirm my account" in the email
    And I am redirected to the Sign In page
    And I fill in the Sign In form correctly
    And I click Log In
    Then I am redirected to the Home page
    And I can see "Signed in successfully" notification


  Scenario: Sad Path - Unsuccessful Sign Up
    And I fill in the User Registration form incorrectly
    And I click Register
    Then I am redirected back to the User Registration Page
    And I can see an Error Notification
    And I can see Sign In link
