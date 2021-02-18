class AddUserIdToGallery < ActiveRecord::Migration[6.1]
  def change
    add_column :galleries, :user_id, :integer
    add_index  :galleries, :user_id    
  end
end
