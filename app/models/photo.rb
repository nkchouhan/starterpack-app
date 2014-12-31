class Photo < ActiveRecord::Base
  paginates_per 12
  mount_uploader :avatar, AvatarUploader
  belongs_to :user

  scope :desc, -> {order("created_at DESC")}

end
