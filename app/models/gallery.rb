class Gallery < ApplicationRecord
  has_many :attachments
  belongs_to :user
  # accepts_nested_attributes_for :attachments
end
