class AddShowOnIndexToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :show_on_index, :boolean, default: true
  end
end
