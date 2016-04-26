class Comment < ActiveRecord::Base
  has_many :subcomments, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Comment"
  belongs_to :user

  validates :content, presence: true
end
