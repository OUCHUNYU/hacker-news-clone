require './spec/spec_helper.rb'

describe "Correct user can", :type => :feature do
  it "delete a post when Correct user" do
    sign_in_a_user('testuser2')
    visit '/posts/new'
    within("#new-post-form") do
      fill_in 'new-post-form-title', with: 'test delete1'
      fill_in 'new-post-form-content', with: 'some content'
    end
    click_button 'Submit'
    expect(page).to have_content 'test delete1'
    click_link "delete-#{Post.last.id}"
    expect(page).not_to have_content 'test delete1'
    click_link('logout')
    expect(page).to have_content "Logout successfully"
  end

  it "not delete other peoples posts" do
    sign_in_a_user('testuser2')
    visit '/'
    expect(page).not_to have_content 'delete'
  end

end