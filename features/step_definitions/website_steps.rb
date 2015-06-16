

Then(/^show me the page$/) do
  save_and_open_page
end


# Preconditions

Given(/^I am an existing registered user$/) do
  @john = User.new( name: "John", username: "John89", email: "john89@example.com", password: "secretpassword", password_confirmation: "secretpassword")
  @john.skip_confirmation! #Skip email confirmation step
  @john.save
end

Given(/^two existing registered users$/) do
  @john = User.new( name: "John", username: "John89", email: "john89@example.com", password: "secretpassword", password_confirmation: "secretpassword")
  @john.skip_confirmation! #Skip email confirmation step
  @john.save

  @jane = User.new( name: "Jane", username: "Jane77", email: "jane77@example.com", password: "secretpassword", password_confirmation: "secretpassword")
  @jane.skip_confirmation! #Skip email confirmation step
  @jane.save
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

When(/^I visit the Users page$/) do
  visit(users_path)
end

And(/^I leave the site$/) do
  expire_cookies
end

When(/^I visit the Edit User page$/) do
  visit(edit_user_path(1))
end

When(/^I visit the Piece page$/) do
  visit(piece_path(1))
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

And /^(?:|I )attach (?:|an|a) "([^"]*)" image/ do |field|
  attach_file(field, File.expand_path("app/assets/images/test.png"))
end

And /^I drop a file into the drop area/ do
  def drop_files files, drop_area_id
    js_script = "fileList = Array();"
    files.count.times do |i|
      # Generate a fake input selector
      page.execute_script("if ($('#seleniumUpload#{i}').length == 0) { seleniumUpload#{i} = window.$('<input/>').attr({id: 'seleniumUpload#{i}', type:'file'}).appendTo('body'); }")
      # Attach file to the fake input selector through Capybara
      attach_file("seleniumUpload#{i}", files[i])
      # Build up the fake js event
      js_script = "#{js_script} fileList.push(seleniumUpload#{i}.get(0).files[0]);"
    end

    # Trigger the fake drop event
    page.execute_script("#{js_script} e = $.Event('drop'); e.originalEvent = {dataTransfer : { files : fileList } }; $('##{drop_area_id}').trigger(e);")
  end

  files = [ File.expand_path('app/assets/images/test.png')]
  drop_files files, 'file_drop_area'
end

And(/^I select a crop area$/) do
  step "I fill in \"crop_x\" with \"100\""
  step "I fill in \"crop_y\" with \"300\""
  step "I fill in \"crop_width\" with \"200\""
  step "I fill in \"crop_height\" with \"200\""
end

And(/^I fill in the Edit Piece form correctly$/) do
  fill_in("Title", with: "My Piece")
  fill_in("Description", with: "This is my test piece...")
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

And(/^I can see correct Username in the nav$/) do
  within("#nav"){ expect(page).to have_content("John")}
end

Then(/^I can see both Usernames on the page$/) do
  within("#main"){ expect(page).to have_content("John")}
  within("#main"){ expect(page).to have_content("Jane")}
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
      expect(field_value).to eq("#{value}")
    else
      assert_match(/#{value}/, field_value)
    end
end

Then(/^I can see my profile avatar thumbnail$/) do
  @john.reload
  expect(page).to have_xpath("//img[@src=\"#{@john.avatar_url(:thumb)}\"]")
end

And(/^I can see correct Piece Title on the page$/) do
  within("#main"){ expect(page).to have_content("My Piece")}
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
