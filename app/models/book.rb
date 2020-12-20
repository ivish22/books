class Book < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  def self.search(search)
      if search.blank?
        Book.all
      else
        Book.where(['content LIKE ?', "%#{search}%"])
      end
  end
end
