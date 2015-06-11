Feature: View User Profile

  As a user
  I want to view a users profile
  In order to see their information

  Scenario: View User Profile
    Given an existing registred user
    When I visit the User page
    Then I can see correct Username on the page
