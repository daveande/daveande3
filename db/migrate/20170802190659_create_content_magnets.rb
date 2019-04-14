class CreateContentMagnets < ActiveRecord::Migration[5.0]
  def change
    create_table :content_magnets do |t|
      t.string :title
      t.text :description
      t.attachment :asset

      t.timestamps
    end
  end
end
