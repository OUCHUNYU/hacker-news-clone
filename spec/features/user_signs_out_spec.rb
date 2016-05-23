require './spec/spec_helper.rb'

describe "User signs out", :type => :feature do
  it "signs out a user" do
    visit 'sessions/new'
    within("#sign-in") do
      fill_in 'signin-email', :with => 'testuser@yahoo.com'
      fill_in 'signin-password', :with => '333666'
    end
    click_button 'Login'
    expect(page).to have_content 'Welcome back testuser'

    click_link('logout')
    expect(page).to have_content "Logout successfully"
  end
end