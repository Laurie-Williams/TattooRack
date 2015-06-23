Feature: Categories Filtering

  As a user
  I want to view pieces from a category

  Background:
    Given an existing registered user
    And three existing "Flash"
    And three existing "Tattoos"

  Scenario: View the last piece for Flash
    When I visit the Home page
    And I follow "Flash"
    And I follow "Show" number "1"
    Then I can see the "2" piece image in "#more_from_user"
    And I can see the "4" piece image in "#more_from_user"
    And I can see the start image in "#more_from_list"
    And I can see the "2" piece image in "#more_from_list"
