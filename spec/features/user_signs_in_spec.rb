require './spec/spec_helper.rb'

describe "User signs in", :type => :feature do
  it "signs in a valid user" do
    visit 'sessions/new'
    within("#sign-in") do
      fill_in 'signin-email', :with => 'testuser@yahoo.com'
      fill_in 'signin-password', :with => '333666'
    end
    click_button 'Login'
    expect(page).to have_content 'Welcome back testuser'
  end

  it "won't sign in an invalid user" do
    visit 'sessions/new'
    within("#sign-in") do
      fill_in 'signin-email', :with => 'invaliduser@yahoo.com'
      fill_in 'signin-password', :with => '32423r2312'
    end
    click_button 'Login'
    expect(page).to have_content 'email and password not match'
  end
end