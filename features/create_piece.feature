Feature: Creat Piece

  As a logged in user
  I want to create a peice
  So it can be seen on my profile

  Scenario: Upload Picture and Publish Piece
    Given I am a logged in user
    When I visit the Home page
    And I follow "Create Peice"
    And I attach a "Piece" image
    And I press "Create Piece"
    And I fill in the Edit Piece form correctly
    And I press "Publish"
    And I visit the Piece page
    Then I can see correct Piece Title on the page

  Scenario: Upload Picture but dont Publish Piece
    Given I am a logged in user
    When I visit the Home page
    And I follow "Create Piece"
    And I attach a "Piece" image
    And I press "Create Piece"
    And I visit the Piece page
    Then I get a Page Not Found Error

  Scenario: Upload Picture and cancel
    Given I am a logged in user
    When I visit the Home page
    And I follow "Create Piece"
    And I attach a "Piece" image
    And I press "Create Piece"
    And I follow "Cancel"
    And I visit the Piece page
    Then I get a Page Not Found Error