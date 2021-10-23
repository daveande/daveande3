class CreateImages < ActiveRecord::Migration[5.0]
  def up
    create_table :images do |t|
      t.timestamps
    end
    add_column :images, :media_file_name, :string
    add_column :images, :media_content_type, :string
    add_column :images, :media_file_size, :integer
    add_column :images, :media_updated_at, :datetime
  end

  def down
    drop_table :images
  end
end
