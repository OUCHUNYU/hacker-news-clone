class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, as: :votable
  belongs_to :user

  validate :valid_url?
  validates :title, presence: true

  private
  def valid_url?
    if self.url.length == 0
      return true
    end
    uri = URI.parse(self.url)
    if !uri.kind_of?(URI::HTTP)
      errors.add(:url, "not valid url!")
    end
  end
end
