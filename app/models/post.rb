class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	belongs_to :source, :class_name => "Post", :foreign_key => "source_id"
end
