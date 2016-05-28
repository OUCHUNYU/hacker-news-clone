require './spec/spec_helper.rb'

describe "User signs up", :type => :feature do
  it "signs up a new user" do
    visit 'sessions/new'
    within("#sign-up") do
      fill_in 'signup-username', :with => 'testuser2'
      fill_in 'signup-email', :with => 'testuser2@yahoo.com'
      fill_in 'signup-password', :with => '333666'
    end
    click_button 'Create'
    expect(page).to have_content 'New user reated successfully'
  end
end