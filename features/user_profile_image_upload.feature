@upload_cleaned
Feature: Profile Picture Upload

  As an existing registered user
  I want to upload a profile picture
  So that it can be seen on my profile


  Scenario: Successful Image upload
    Given I am logged in as "John"
    When I visit the Edit User page
    And attach an "user_avatar" image
    And I press "Upload Now"
    Then I can see my profile avatar thumbnail

