@javascript @upload_cleaned
Feature: Creat Piece

  As a logged in user
  I want to create a piece
  So it can be seen on my profile

  Scenario: Upload Picture and Publish Piece
    Given I am a logged in user
    When I visit the Home page
    And I follow "Create Piece"
    And I drop a file into the drop area
    And show me the page
    And I fill in the Edit Piece form correctly
    And I press "Publish"
    And I visit the Piece page
    Then I can see correct Piece Title on the page

  Scenario: Upload Picture but dont Publish Piece
    Given I am a logged in user
    When I visit the Home page
    And I follow "Create Piece"
    And I attach a "Piece" image
    And I visit the Piece page
    Then I can see an Error Flash

  Scenario: Upload Picture and cancel
    Given I am a logged in user
    When I visit the Home page
    And I follow "Create Piece"
    And I attach a "Piece" image
    And I follow "Cancel"
    And I visit the Piece page
    Then I can see an Error Flash