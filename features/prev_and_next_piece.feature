Feature: Previous and Next Piece

  As a User
  I want to see a pieces previous and next piece
  So I can browse related pieces

  Background:
    Given an existing registered user
    And three existing pieces

  Scenario: View the second piece
    When I visit the Pieces page
    And I follow "Show" number "2"
    Then I can see the "1" piece image in "#more_from_user"
    And I can see the "3" piece image in "#more_from_user"
    And I can see the "1" piece image in "#more_from_list"
    And I can see the "3" piece image in "#more_from_list"

  Scenario: View the first piece
    When I visit the Pieces page
    And I follow "Show" number "1"
    Then I can see the "2" piece image in "#more_from_user"
    And I can see the "2" piece image in "#more_from_list"
    And I can see the start image in "#more_from_user"
    And I can see the start image in "#more_from_list"

  Scenario: View the last piece
    When I visit the Pieces page
    And I follow "Show" number "3"
    Then I can see the "2" piece image in "#more_from_user"
    And I can see the "2" piece image in "#more_from_list"
    And I can see the end image in "#more_from_user"
    And I can see the end image in "#more_from_list"

  Scenario: View the last piece
    When I visit the Users page
    And I follow "Show" number "1"
    And I follow "Show" number "2"
    Then I can see the "1" piece image in "#more_from_user"
    And I can see the "3" piece image in "#more_from_user"
    And I can not see "#more_from_list"