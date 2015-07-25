
@upload_cleaned
Feature: Pieces can have tags

  As a user
  I want to click a tag for a Piece
  So that I can view more Pieces with this tag

  Scenario: I can filter Pieces by tag
    Given I am logged in as "John"
    And a "Tattoo" with tag "tag1"
    And a "Tattoo" with tag "tag2"
    And I visit the "1" Piece page
    Then I can see "tag1"
    When I follow "tag1"
    Then I can see the "1" piece image in "body"


#  @javascript
#  Scenario: Tag field has autocomplete
#    Given I am logged in as "John"
#    And a "Tattoo" with tag "tag1"
#    And a "Tattoo" with tag "tag2"
#    And a "Tattoo" with tag ""
#    When I visit the Edit "3" Piece page
#    And I fill in the "#tag" autocomplete field with "ta"
#    And show me the page
#    Then I can see "tag1"
#    And I can see "tag2"
#    When I click the "li" containing "tag1"
#    When I hit Enter on "tag"
#    And I can see "tag1"
#    And I can not see "test2"

