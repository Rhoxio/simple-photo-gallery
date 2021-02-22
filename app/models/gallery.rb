class Gallery < ApplicationRecord
  has_many :attachments
  belongs_to :user
  has_rich_text :description
  # accepts_nested_attributes_for :attachments
end
