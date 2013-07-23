class Comment < ActiveRecord::Base
  validates_presence_of :name, :body, :email
  belongs_to :page
end
