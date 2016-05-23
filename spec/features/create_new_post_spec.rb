require './spec/spec_helper.rb'

describe "Create a new post", :type => :feature do
  it "should redirect to Login page if not signed in" do
    visit '/posts/new'
    within("#new-post-form") do
      fill_in 'new-post-form-title', :with => 'test title'
      fill_in 'new-post-form-content', :with => 'some content'
    end
    click_button 'Submit'
    expect(page).to have_content 'You need to login'
  end

  it "when signed in a user can create a new post and redirect to index" do
    sign_in_a_user
    visit '/posts/new'
    within("#new-post-form") do
      fill_in 'new-post-form-title', :with => 'test title'
      fill_in 'new-post-form-content', :with => 'some content'
    end
    click_button 'Submit'
    expect(page).to have_content 'test title'
  end

  it "when creating without valid info shoud show error message" do
    sign_in_a_user
    visit '/posts/new'
    within("#new-post-form") do
      fill_in 'new-post-form-title', :with => ''
      fill_in 'new-post-form-content', :with => 'some content'
    end
    click_button 'Submit'
    expect(page).to have_content "Title can't be blank"
  end

end