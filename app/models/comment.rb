class Comment < ActiveRecord::Base
  has_many :subcomments, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy
  has_many :votes, as: :votable
  belongs_to :parent, class_name: "Comment"
  belongs_to :user
  belongs_to :post

  default_scope -> { order(created_at: :asc) }
  validates :content, presence: true

end
