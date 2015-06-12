Feature: Profile Picture Upload

  As an existing registered user
  I want to upload a profile picture
  So that it can be seen on my profile


  Before do
  end


  Scenario: Successful Image upload
    Given I am a logged in user
    When I visit the Edit User page
    And attach an avatar image
    And I press "Upload Now"
    And show me the page
    Then I can see my profile avatar thumbnail

