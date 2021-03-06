Then(/^show me the page$/) do
  save_and_open_page
end


# Preconditions

Given(/^I am an existing registered user named "([^"]*)"$/) do |name|
  Chewy.strategy(:atomic) do
    if name == "John"
      @john = User.new( name: "John", username: "John89", email: "john89@example.com", password: "secretpassword", password_confirmation: "secretpassword")
      @john.skip_confirmation! #Skip email confirmation step
      @john.save
    elsif name == "Jane"
      @jane = User.new( name: "Jane", username: "Jane77", email: "jane77@example.com", password: "secretpassword", password_confirmation: "secretpassword")
      @jane.skip_confirmation! #Skip email confirmation step
      @jane.save
    end
  end

end

Given(/^two existing registered users$/) do
  step "I am an existing registered user named \"John\""
  step "I am an existing registered user named \"Jane\""
end

Given(/^an existing registered user "([^"]*)"$/) do |name|
  step "I am an existing registered user named \"#{name}\""
end

Given(/^I am logged in as "([^"]*)"$/) do |name|
  step "I am an existing registered user named \"#{name}\""
  step "I visit the Sign In page"
  step "I fill in the Sign In form correctly as \"#{name}\""
  step "I press \"Sign In\""
end

And(/^three existing pieces of category "([^"]*)"/) do |category|
  step "a \"#{category}\" with tag \"test\""
  step "a \"#{category}\" with tag \"test\""
  step "a \"#{category}\" with tag \"test\""
end

When(/^a "([^"]*)" with tag "(.*?)"$/) do |category, tag|
  Chewy.strategy(:atomic) do
    category_id = nil
    case category
      when "Tattoos"
        category_id =  1
      when "Flash"
        category_id =  2
      when "Artworks"
        category_id =  3
      when "Inspirations"
        category_id =  4
    end

    @piece = FactoryGirl.create(:piece, user_id: 1, category_id: category_id, tag_list: tag)
  end
end

When(/^a "([^"]*)" with description "(.*?)"$/) do |category, description|
  Chewy.strategy(:atomic) do
  category_id = nil
    case category
      when "Tattoos"
        category_id =  1
      when "Flash"
        category_id =  2
      when "Artworks"
        category_id =  3
      when "Inspirations"
        category_id =  4
    end

    @piece = FactoryGirl.create(:piece, user_id: 1, category_id: category_id, description: description)
  end
end

When(/^a "([^"]*)" with title "(.*?)"$/) do |category, title|
  Chewy.strategy(:atomic) do
    category_id = nil
    case category
      when "Tattoos"
        category_id =  1
      when "Flash"
        category_id =  2
      when "Artworks"
        category_id =  3
      when "Inspirations"
        category_id =  4
    end

    @piece = FactoryGirl.create(:piece, user_id: 1, category_id: category_id, title: title)
  end
end

When(/^a tattoo by user "(.*?)"$/) do | user |

  Chewy.strategy(:atomic) do
    user_id = nil
    case user
      when "John"
        user_id =  1
      when "Jane"
        user_id =  2
    end

    @piece = FactoryGirl.create(:piece, user_id: user_id, category_id: 1, tag_list: "")
  end
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

When(/^I visit the "([^"]*)" Piece page$/) do |piece_number|
  visit(piece_path(piece_number.to_i))
end

When(/^I visit the Pieces page$/) do
  visit(pieces_path)
end

When(/^I visit the Edit "([^"]*)" Piece page$/) do |piece_number|
  visit(edit_piece_path(piece_number.to_i))
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

And(/^I fill in the Sign In form correctly as "([^"]*)"$/) do |user|
  email = "john89@example.com" if user == "John"
  email = "jane77@example.com" if user == "Jane"
  fill_in("Email", with: email)
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
  fill_in("crop_x", :with => "100", visible: false)
  fill_in("crop_y", :with => "100", visible: false)
  fill_in("crop_width", :with => "100", visible: false)
  fill_in("crop_height", :with => "100", visible: false)
end

And(/^I fill in the Edit Piece form correctly$/) do
    fill_in("Title", with: "My Piece")
    fill_in("Description", with: "This is my test piece...")
end

And(/^I fill in the comment form$/) do
  fill_in("comment_comment", with: "Test Comment")
end

And(/^I fill in the "(.*?)" autocomplete field with "(.*?)"$/) do |field, text|
  page.execute_script "$('#{field}').val('#{text}')"
  page.execute_script "$('#{field}').trigger('focus')"
  page.execute_script "$('#{field}').trigger('keydown')"
end


# Click

And /^I hover over user dropdown/ do
  page.execute_script("$('#user_dropdown>ul').css('display','block')");
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
    click_link(link)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)" number "([^"]*)"$/ do |link, number|
  find(:xpath, "(//a[text()='#{link}'])[#{number}]").click
end

When /^(?:|I )click the "([^"]*)" containing "([^"]*)"$/ do |element, text|
  page.execute_script "$('#{element}:contains(\"#{text}\")').trigger('mouseenter').trigger('click')"
end

When /^(?:|I )hit Enter on "([^"]*)"$/ do |element|
  page.execute_script "var e = jQuery.Event('keypress'); e.which = 13; $('##{element}').trigger(e);"

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

Then(/^I am redirected to the crop page$/) do
  expect(current_path).to eq(pieces_crop_path)
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
  expect(page).to have_xpath("//img[@src=\"#{@john.avatar_url(:small)}\"]")
end

And(/^I can see correct Piece Title on the page$/) do
  within("#main"){ expect(page).to have_content("My Piece")}
end

Then(/^I can see the "(.*?)" piece image in "(.*?)"$/) do |piece_number, prev_next_section|
  piece = Piece.find(piece_number)
  within( prev_next_section){ expect(page).to have_xpath("//img[@src=\"#{piece.image_url}\"]") }
end

Then(/^I can not see the "(.*?)" piece image in "(.*?)"$/) do |piece_number, prev_next_section|
  piece = Piece.find(piece_number)
  within( prev_next_section){ expect(page).not_to have_xpath("//img[@src=\"#{piece.image_url}\"]") }
end

And(/^I can see the start image in "(.*?)"$/) do |prev_next_section|
  within(prev_next_section){ expect(page).to have_xpath("//img[contains(@src,'start.png')]") }
end

And(/^I can see the end image in "(.*?)"$/) do |prev_next_section|
  within(prev_next_section){ expect(page).to have_xpath("//img[contains(@src,'end.png')]") }
end

Then /^(?:|I )can not see "(.*?)"$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )can see "(.*?)"$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

And(/^I can see comment$/) do
  expect(page).to have_content('Test Comment')
end

Then(/^I can see like count is "(.*?)"$/) do |count|
  within("#likes"){expect(page).to have_content("#{count}")}
end

Then(/^"(.*?)" has content "(.*?)"$/) do |element, content|
  within("#{element}"){expect(page).to have_content("#{content}")}
end

Then(/^"(.*?)" does not have content "(.*?)"$/) do |element, content|
  within("#{element}"){expect(page).not_to have_content("#{content}")}
end


# Notifications

And(/^I can see a Notice Flash$/) do
  within("#flash"){ expect(page).to have_css('.notice')}
end

And(/^I can see an Error Flash$/) do
  within("#flash"){ expect(page).to have_css('.alert')}
end

And(/^I can see Form Errors$/) do
  within("#error_explanation"){ expect(page).to have_css('li')}
end
