class Attachment < ApplicationRecord
  has_one_attached :photo
  belongs_to :gallery, optional: true
end
