Feature: List Artists Page

  As a User
  I want to visit users page
  So that see all registered user profiles listed

  Scenario:
    Given two existing registered users
    When I visit the Users page
    Then I can see both Usernames on the page