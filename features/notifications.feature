@upload_cleaned @javascript
Feature: Notifies user of likes and comments on their peices

  Scenario: User is notified that their peice was liked and commented on
    Given two existing registered users
    And a tattoo by user "John"
    And I am logged in as "Jane"
    When I visit the "1" Piece page
    And I follow "Like"
    And I fill in the comment form
    And I press "Post Comment"
    And I hover over user dropdown
    And I follow "Sign Out"
    When I am logged in as "John"
    Then "#notifications_button" has content "Notifications (2)"
    When I follow "notifications_button"
    Then "#notifications_panel" has content "Jane Liked one of your Pieces"
    Then "#notifications_panel" has content "Jane commented on one of your Pieces"
    When I follow "notifications_button"
    Then "#notifications_panel" does not have content "Jane"
    Then "#notifications_button" has content "Notifications (0)"
