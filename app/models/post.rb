class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user

  validate :valid_url?
  validates :title, presence: true

  private
  def valid_url?
    uri = URI.parse(self.url)
    if !uri.kind_of?(URI::HTTP)
      errors.add(:url, "not valid url!")
    end
  end
end
