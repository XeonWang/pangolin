class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :sub_comments, :class_name => "Comment", :foreign_key => "p_id"
end
