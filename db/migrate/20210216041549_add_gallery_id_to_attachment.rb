class AddGalleryIdToAttachment < ActiveRecord::Migration[6.1]
  def change
    add_column :attachments, :gallery_id, :integer
    add_index  :attachments, :gallery_id
  end
end
