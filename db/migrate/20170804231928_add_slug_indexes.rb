class AddSlugIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, :slug
  end
end
