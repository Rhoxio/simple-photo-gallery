class Attachment < ApplicationRecord
  has_one_attached :photo
end
