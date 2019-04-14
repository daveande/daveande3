class AddFeaturedImageIdToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :featured_image_id, :integer
  end
end
