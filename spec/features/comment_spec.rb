require './spec/spec_helper.rb'

describe "When logged in", :type => :feature do
    before :each do
      sign_in_a_user('testuser2')
    end
  it "a user can comment on a post" do
    visit "/posts/#{Post.last.id}"
    within("#new-comment-form") do
      fill_in 'new-comment-textarea', :with => 'test comment'
    end
    click_button 'Comment'
    expect(page).to have_content 'test comment'
  end

  it "a user can comment on a comment" do
    visit "/posts/#{Post.last.id}"
    click_link("reply-0")
    expect(page).to have_content 'Write a comment for:'
    within("#new-subcomment-form") do
      fill_in 'new-subcomment-textarea', :with => 'test sub-comment'
    end
    click_button 'Comment'
    expect(page).to have_content 'test sub-comment'
  end

end