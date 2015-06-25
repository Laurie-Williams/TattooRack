Feature: User Email Registration

  As a user
  I want to create a user account with an Email and Password
  So I can access it on the site

  Background:
    Given I visit the User Registration page

  Scenario: Happy Path - Seccessful Sign Up
    And I fill in the User Registration form correctly
    And I press "Create Account"
    Then I am redirected to the Home page
    And I can see a Notice Flash
    And "john89@example.com" should receive an email with subject "Confirmation instructions"
    When I open the email with subject "Confirmation instructions"
    And I follow "Confirm my account" in the email
    And I am redirected to the Sign In page
    And I can see a Notice Flash
    And I fill in the Sign In form correctly as "John"
    And I press "Sign In"
    Then I am redirected to the Home page
    And I can see a Notice Flash


  Scenario: Sad Path - Unsuccessful Sign Up
    And I fill in the User Registration form incorrectly
    And I press "Create Account"
    Then I can see the registration form
    And I can see Form Errors
    And I can see Sign In link


