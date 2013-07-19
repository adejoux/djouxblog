class Image < ActiveRecord::Base
  attr_accessible :file, :name

  mount_uploader :file, FileUploader

end
