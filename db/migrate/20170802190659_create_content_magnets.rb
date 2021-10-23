class CreateContentMagnets < ActiveRecord::Migration[5.0]
  def up
    create_table :content_magnets do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
    add_column :content_magnets, :asset_file_name, :string
    add_column :content_magnets, :asset_content_type, :string
    add_column :content_magnets, :asset_file_size, :integer
    add_column :content_magnets, :asset_updated_at, :datetime
  end

  def down
    drop_table :content_magnets
  end
end
