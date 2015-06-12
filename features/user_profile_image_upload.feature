Feature: Profile Picture Upload

  As an existing registered user
  I want to upload a profile picture
  So that it can be seen on my profile

  Scenario: Successful upload
    Given I am a logged in user
    When I visit the Edit User page
    And attach a profile image
    And I press "Upload Now"
    Then I can see an my profile image thumbnail

