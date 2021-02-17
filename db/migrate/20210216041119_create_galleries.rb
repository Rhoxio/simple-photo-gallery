class CreateGalleries < ActiveRecord::Migration[6.1]
  def change
    create_table :galleries do |t|
      t.text :description
      t.string :title

      t.timestamps
    end
  end
end
