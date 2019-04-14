class AddSeoTagsAndSlugToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :seo_title, :string
    add_column :posts, :meta_description, :text
    add_column :posts, :meta_keywords, :string
    add_column :posts, :slug, :string
  end
end
