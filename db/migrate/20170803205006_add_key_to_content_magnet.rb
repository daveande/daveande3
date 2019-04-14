class AddKeyToContentMagnet < ActiveRecord::Migration[5.0]
  def change
    add_column :content_magnets, :token, :string
    add_index :content_magnets, :token
  end

end
