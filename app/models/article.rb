class Article < ActiveRecord::Base
  attr_accessible :author, :content, :title
  has_paper_trail :on => [:update, :destroy]
end
