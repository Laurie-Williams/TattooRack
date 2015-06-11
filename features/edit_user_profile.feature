Feature: Edit User Profile

  As a logged in user
  I want to edit my user profile
  So that I can change the account information


  Scenario: Happy Path - Successfully edit Bio
    Given I am a logged in user
    And I visit the Home page
    And I follow "Account Settings"
    And I fill in "Bio" with "I am an artist"
    And I press "Update Settings"
    And show me the page
    Then I can see a Notice Flash
    And the "Bio" field should contain "I am an artist"
