@upload_cleaned
Feature: Previous and Next Piece

  As a User
  I want to see a pieces previous and next piece
  So I can browse related pieces

  Background:
    Given an existing registered user "John"
    And three existing pieces of category "Tattoo"

  Scenario: View the second piece for all pieces
    When I visit the Home page
    And I follow "Pieces"
    And I follow "Piece" number "2"
    Then I can see the "1" piece image in "#more_from_user"
    And I can see the "3" piece image in "#more_from_user"
    And I can see the "1" piece image in "#more_from_list"
    And I can see the "3" piece image in "#more_from_list"

  Scenario: View the first piece for all pieces
    When I visit the Home page
    And I follow "Pieces"
    And I follow "Piece" number "1"
    Then I can see the "2" piece image in "#more_from_user"
    And I can see the "2" piece image in "#more_from_list"
    And I can see the start image in "#more_from_user"
    And I can see the start image in "#more_from_list"

  Scenario: View the last piece for all pieces
    When I visit the Home page
    And I follow "Pieces"
    And I follow "Piece" number "3"
    Then I can see the "2" piece image in "#more_from_user"
    And I can see the "2" piece image in "#more_from_list"
    And I can see the end image in "#more_from_user"
    And I can see the end image in "#more_from_list"

  Scenario: View the last piece for user
    When I visit the Home page
    And I follow "Artists" number "1"
    And I follow "John" number "1"
    And I follow "Piece" number "2"
    Then I can see the "1" piece image in "#more_from_user"
    And I can see the "3" piece image in "#more_from_user"
    And I can not see "#more_from_list"

