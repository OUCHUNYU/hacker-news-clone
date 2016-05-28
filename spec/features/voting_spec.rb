require './spec/spec_helper.rb'

describe "a logged in user can vote", :type => :feature do
  before :each do
    sign_in_a_user('testuser2')
  end

  it "should increas the vote count by 1" do
    visit '/'
    vote_count = Post.first.votes.count
    click_link("vote-0")
    expect(Post.first.votes.count).to eq(vote_count + 1)
  end

  it "should not see vote links that have been clicked by the user" do
    visit '/'
    expect(page).to have_no_css("a[href='/posts/#{Post.first.id}/votes']")
  end

end