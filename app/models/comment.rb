class Comment < ActiveRecord::Base
  attr_accessible :body, :email, :name, :post_id

  validates_presence_of :name, :body
  belongs_to :post
end
