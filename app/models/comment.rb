class Comment < ActiveRecord::Base
  attr_accessible :body, :email, :name, :page_id

  validates_presence_of :name, :body
  belongs_to :page
end
