class Comment < ActiveRecord::Base
  has_many :subcomments, class_name: "Comment", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Comment"
end
