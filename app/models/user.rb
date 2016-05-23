class User < ActiveRecord::Base
  has_many :posts,      dependent: :destroy
  has_many :comments,   dependent: :destroy
  has_many :votes,      dependent: :destroy

  before_save {self.email.downcase!}

  validates :username, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length:     { maximum: 150 },
                                    format:     { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user_record = User.find_by(email: email)
    if user_record
      true if user_record.password == password
    else
      false
    end
  end

end
