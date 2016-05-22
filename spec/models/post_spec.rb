require './spec/spec_helper.rb'

# table name: posts

# t.text    :title,  null: false
# t.text    :url
# t.text    :content
# t.integer :user_id

# t.timestamps

describe Post do

  before(:each) do
    @post = Post.new(title: "test title", content: "test content")
  end

  describe "initial post is valid" do
    it "returns true" do
      expect(@post.valid?).to be true
    end
  end

  describe "url validation" do
    it "should be valid with a valid url" do
      @post.url = "https://github.com/OUCHUNYU"
      expect(@post.valid?).to be true
    end
    it "should be invalid with an invalid url" do
      @post.url = "adsfsdgitdsfsd^25198/OdsfsNYU"
      expect(@post.valid?).to be false
    end
  end

  describe "title validation" do
    it "must have a title presence" do
      @post.title = nil
      expect(@post.valid?).to be false
    end
  end

  describe "associations" do
    it "has many comments" do
      expect(@post.comments).to eq([])
    end
    it "has many votes" do
      expect(@post.votes).to eq([])
    end
    it "a post belongs to a user" do
      user = User.create(username: "Chunyu", email: "ouchunyu@yahoo.com", password: "333666")
      post = user.posts.create(title: "test title", content: "test content")
      expect(post.user).to eq(user)
      user.destroy
      post.destroy
    end
  end
end