class New < ActiveRecord::Base
  extend Enumerize
  
  #mount_uploader :image, FileUploader
  
  #validates_presence_of :name, :summary, :image, :member_id, allow_nil: true
  validates :email, presence: true, email: true
  
end
