@javascript @upload_cleaned
Feature: Creat Piece

  As a logged in user
  I want to create a piece
  So it can be seen on my profile

  Scenario: Upload Picture and Publish Piece
    Given I am logged in as "John"
    When I visit the Home page
    And I follow "create"
    And I drop a file into the drop area
    And I select a crop area
    And I press "Upload"
    And I fill in the Edit Piece form correctly
    And I press "Publish"
    And I visit the "1" Piece page
    Then I can see correct Piece Title on the page

  Scenario: Upload Picture but dont Publish Piece
    Given I am logged in as "John"
    When I visit the Home page
    And I follow "create"
    And I drop a file into the drop area
    And I select a crop area
    And I press "Upload"
    And I visit the "1" Piece page
    Then I can see an Error Flash

  Scenario: Upload Picture and cancel
    Given I am logged in as "John"
    When I visit the Home page
    And I follow "create"
    And I drop a file into the drop area
    And I select a crop area
    And I press "Upload"
    And I follow "Delete"
    And I visit the "1" Piece page
    Then I can see an Error Flash