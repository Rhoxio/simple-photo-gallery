class Gallery < ApplicationRecord
  has_many :attachments
  belongs_to :user
  has_rich_text :description
  # accepts_nested_attributes_for :attachments

  def first_photo
    attachments.each do |attachment|
      if attachment.photo.attached?
        return attachment.photo
      end
    end
    return false
  end

  def has_photos?
    result = attachments.select do |att|
      if att.photo.attached?
        true
      end
    end
    return true if result.length > 0
    return false
  end

end
