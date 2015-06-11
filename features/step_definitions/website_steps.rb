

Then(/^show me the page$/) do
  save_and_open_page
end


# Preconditions

Given(/^I am an existing registered user$/) do
  @john = User.new( name: "John", username: "John89", email: "john89@example.com", password: "secretpassword", password_confirmation: "secretpassword")
  @john.skip_confirmation! #Skip email confirmation step
  @john.save
end

Given(/^an existing registred user$/) do
  step "I am an existing registered user"
end

Given(/^I am a logged in user$/) do
  step "I am an existing registered user"
  step "I visit the Sign In page"
  step "I fill in the Sign In form correctly"
  step "I press \"Sign In\""
end

# Visit

Given(/^I visit the User Registration page$/) do
  visit(new_user_registration_path)
end

When(/^I visit the Sign In page$/) do
  visit(new_user_session_path)
end

When(/^I visit the Home page$/) do
  visit(root_path)
end

When(/^I visit the User page$/) do
  visit(user_path(1))
end

And(/^I leave the site$/) do
  expire_cookies
end

# Form

And(/^I fill in the User Registration form correctly$/) do
  fill_in("Name", with: "John")
  fill_in("Username", with: "John89")
  fill_in("Email", with: "john89@example.com")
  fill_in("Password", with: "secretpassword")
  fill_in("Password confirmation", with: "secretpassword")
end

And(/^I fill in the User Registration form incorrectly$/) do
  fill_in("Name", with: "John")
end

And(/^I fill in the Sign In form correctly$/) do
  fill_in("Email", with: "john89@example.com")
  fill_in("Password", with: "secretpassword")
end

And(/^I fill in the Sign In form with invalid data$/) do
  fill_in("Email", with: "john89@example.com")
  fill_in("Password", with: "")
end

And(/^I fill in the Sign In form with non\-existent user$/) do
  fill_in("Email", with: "notregistered@example.com")
  fill_in("Password", with: "secretpassword")
end

And(/^the Username field contains correct Username$/) do
  withing("#form"){expect(page).to have_field("Name", with: "John")}
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end


# Click

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end


# Redirect

Then(/^I am redirected to the User Edit page$/) do
  expect(current_path).to eq(edit_user_path(1))
end

Then(/^I am redirected to the Home page$/) do
  expect(current_path).to eq(root_path)
end

Then(/^I am redirected to the Users index page$/) do
  expect(current_path).to eq(users_path)
end

Then(/^I am redirected to my User Profile page$/) do
  expect(current_path).to eq(user_path(1))
end

Then(/^I am redirected to the Sign In page$/) do
  expect(current_path).to eq(new_user_session_path)
end

Then(/^I am redirected back to the User Registration Page$/) do
  expect(current_path).to eq(new_user_registration_path)
end


# Page Content

And(/^I can see correct Username on the page$/) do
  within("#main"){ expect(page).to have_content("John")}
end

And(/^I can see Sign Out Link$/) do
  expect(page).to have_link("Sign Out", destroy_user_session_path )
end

And(/^I can see the registration form$/) do
  expect(page).to have_css("form#new_user")
end

And(/^I can see Sign In link$/) do
  within(:css, "#nav"){ expect(page).to have_content("Sign In")}
end

Then /^the "([^"]*)" field should contain "([^"]*)"$/ do |field, value|
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
end


# Notifications

And(/^I can see a Notice Flash$/) do
  within("#Flash"){ expect(page).to have_css('.notice')}
end

And(/^I can see an Error Flash$/) do
  within("#Flash"){ expect(page).to have_css('.alert')}
end

And(/^I can see Form Errors$/) do
  within("#error_explanation"){ expect(page).to have_css('li')}
end
