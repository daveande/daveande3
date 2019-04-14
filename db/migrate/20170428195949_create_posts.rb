class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :subtitle
      t.text :body_markdown
      t.text :body_html
      t.datetime :published_at

      t.timestamps
    end
  end
end
