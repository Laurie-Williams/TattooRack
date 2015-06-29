Feature: User can Like resources

  As a User
  I want to like a Piece
  So that its like count goes up

  Scenario: Like and unlike a Piece

    Given three existing pieces of category "Tattoo"
    And an existing registered user "John"
    And I am logged in as "Jane"
    When I visit the "1" Piece page
    Then I can see like count is "0"
    When I follow "Like"
    Then I can see like count is "1"
    When I follow "Unlike"
    Then I can see like count is "0"
