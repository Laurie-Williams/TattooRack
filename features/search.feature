@upload_cleaned @javascript
Feature: "Search Pieces by keywords"

  Scenario: Search for keyword
    Given an existing registered user "John"
    And a "Tattoo" with tag "keyword"
    And a "Tattoo" with description "This contains keyword"
    And a "Tattoo" with title "This contains keyword"
    And a "Tattoo" with tag ""
    And I visit the Home page
    When I fill in "q" with "keyword"
    And I hit Enter on "q"
    Then I can see the "1" piece image in "body"
    Then I can see the "2" piece image in "body"
    Then I can see the "3" piece image in "body"
    Then I can not see the "4" piece image in "body"

  Scenario: Search for Name
    Given two existing registered users
    And a tattoo by user "Jane"
    And I visit the Home page
    When I fill in "q" with "Jane"
    And I hit Enter on "q"
    And I can not see the "1" piece image in "body"
    And I can see "Jane"
    And I can not see "John"


