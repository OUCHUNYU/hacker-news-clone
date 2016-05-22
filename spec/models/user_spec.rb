require './spec/spec_helper.rb'
# Table name: users

# t.string :username,      null: false
# t.string :email,         null: false
# t.string :password_hash

# t.timestamps

# before testing run command  rake db:test:prepare

describe User do
  let(:user) { User.new(username: "Chunyu", email: "ouchunyu@yahoo.com", password: "333666") }

  describe "Initial user is valid" do
    it "everything is valid" do
      expect(user.valid?).to be true
    end
  end

  describe "username validation" do
    it "must have username presence" do
      user.username = nil
      expect(user.valid?).to be false
    end
    it "should have username no longer than 50" do
      user.username = "a" * 51
      expect(user.valid?).to be false
      user.username = "chunyu"
    end
  end

  describe "email validation" do
    it "must have email presence" do
      user.email = nil
      expect(user.valid?).to be false
    end
    it "must have email no longer than 150" do
      user.email = "#{'ouchunyu' * 150}@yahoo.com"
      expect(user.valid?).to be false
    end
    it "must have valid email" do
      user.email = "ouchunyu.com"
      expect(user.valid?).to be false
    end
    it "has down cased email" do
      user.email = "OUCHUNYU@YAHOO.COM"
      user.save!
      expect(user.email).to eq("ouchunyu@yahoo.com")
      user.destroy
    end
  end

  describe "associations" do
    it 'has many posts' do
      expect(user.posts).to eq([])
    end
    it 'has many comments' do
      expect(user.comments).to eq([])
    end
    it 'has many votes' do
      expect(user.votes).to eq([])
    end
  end
end