Feature: User is Remembered

  As a registered user
  I want to be automatically logged in
  So I dont have to log in manually again

  Scenario:
    Given I am an existing registered user
    When I visit the Sign In page
    And I fill in the Sign In form correctly
    And I check "Remember me"
    And I press "Sign In"
    And I leave the site
    And I visit the Home page
    Then I can see Sign Out Link
