Given(/^I visit the User Registration page$/) do
  visit(new_user_registration_path)
end

And(/^I fill in the User Registration form correctly$/) do
  fill_in("Name", with: "John")
  fill_in("Username", with: "John89")
  fill_in("Email", with: "John89@example.com")
  fill_in("Password", with: "secretpassword")
end

And(/^I click Register$/) do
  click_button("Create Account")
end

Then(/^I am redirected to the User Edit page$/) do
  expect(current_path).to eq(edit_user_path(1))
end

And(/^the Username field contains correct Username$/) do
  withing("#form"){expect(page).to have_field("Name", with: "John")}
end

When(/^I click my User Profile Link$/) do
  click_link("John")
end

Then(/^I am redirected to my User Profile page$/) do
  expect(current_path).to eq(user_path(1))
end

And(/^I can see my Username on the page$/) do
  within("#main"){ expect(page).to have_content("John")}
end

And(/^I can see Sign Out Link$/) do
  expect(page).to have_link("Sign Out", destroy_user_session_path )
end

And(/^I fill in the User Registration form incorrectly$/) do
  fill_in("Name", with: "John")
end

Then(/^I am redirected back to the User Registration Page$/) do
  expect(current_path).to eq(new_user_registration_path)
end

And(/^I can see an Error Notification$/) do
  expect(page).to have_content("errors")
end

And(/^I can see Sign In link$/) do
  within(:css, "#nav"){ expect(page).to have_content("Sign In")}
end