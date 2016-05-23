class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, as: :votable
  belongs_to :user

  validate :valid_url?
  validates :title, presence: true

  private
  def valid_url?
    if self.url == nil || self.url == ''
      return true
    end
    begin
      uri = URI.parse(self.url)
    rescue Exception => e
      errors.add(:url, "not valid url!")
      return false
    end

    if !uri.kind_of?(URI::HTTP)
      errors.add(:url, "not valid url!")
      return false
    end
  end
end
