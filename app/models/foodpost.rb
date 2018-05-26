class Foodpost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id,      presence: true
  validates :protein,      presence: true
  validates :fat,          presence: true
  validates :carbohydrate, presence: true
  validates :content, length: { maximum: 400 }
  validate  :picture_size
  
  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
