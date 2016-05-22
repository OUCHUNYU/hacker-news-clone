require './spec/spec_helper.rb'

# table name: comments

# t.text    :content,    null: false
# t.integer :parent_id
# t.integer :post_id
# t.integer :user_id

# t.timestamps

describe Comment do
  before(:each) do
    @comment = Comment.new(content: "Testing content")
  end

  describe "content validation" do
    it "must have content presence" do
      @comment.content = nil
      expect(@comment.valid?).to be false
    end
  end

  describe "associations" do
    it "has many votes" do
      expect(@comment.votes).to eq([])
    end

    it "has many subcomments" do
      expect(@comment.subcomments).to eq([])
    end

    it "belongs to a parent" do
      parent_comment = Comment.create(content: "Parent content")
      parent_comment.subcomments << @comment
      parent_comment.save
      expect(@comment.parent).to eq(parent_comment)
      @comment.destroy
      parent_comment.destroy
    end

    it "belongs to a user" do
      user = User.create(username: "Chunyu", email: "ouchunyu@yahoo.com", password: "333666")
      user.comments << @comment
      user.save
      expect(@comment.user).to eq(user)
      user.destroy
      @comment.destroy
    end

    it "belongs to a post" do
      post = Post.create(title: "test title", content: "test content")
      post.comments << @comment
      post.save
      expect(@comment.post).to eq(post)
      post.destroy
      @comment.destroy
    end
  end
end