require './spec/spec_helper.rb'

# table name: votes

# t.integer :user_id
# t.integer :votable_id
# t.string :votable_type

# t.timestamps

describe Vote do
  describe "association" do
    it "blongs to a user" do
      user = User.create(username: "Chunyu", email: "ouchunyu@yahoo.com", password: "333666")
      vote = user.votes.create()
      expect(vote.user).to eq(user)
      user.destroy
    end

    it "blongs to a comment" do
      comment = Comment.create(content: "Testing content")
      vote = comment.votes.create()
      expect(comment.votes.last).to eq(vote)
      comment.destroy
      vote.destroy
    end

    it "blongs to a post" do
      post = Post.create(title: "test title", content: "test content")
      vote = post.votes.create()
      expect(post.votes.last).to eq(vote)
      post.destroy
      vote.destroy
    end
  end
end