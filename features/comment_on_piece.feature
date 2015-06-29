Feature: Comment on Piece

  As a user
  I want to comment on a piece
  So others can see my comment

  Scenario: Create and Destroy Comment
    Given two existing registered users
    And three existing pieces of category "Tattoo"
    When I visit the Sign In page
    And I fill in the Sign In form correctly as "Jane"
    And I press "Sign In"
    And I visit the "1" Piece page
    And I fill in the comment form
    And I press "Post Comment"
    And I can see "Test Comment"
    And I follow "Delete Comment" number "1"
    And I can not see "Test Comment"