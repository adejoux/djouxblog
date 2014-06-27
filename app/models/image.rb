class Image < ActiveRecord::Base
  mount_uploader :file, FileUploader
  validates_uniqueness_of :name

end
