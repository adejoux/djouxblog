class Article < ActiveRecord::Base
  attr_accessible :author, :content, :title
end
