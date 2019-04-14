class Post < ApplicationRecord
  attr_accessor :is_published

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  acts_as_taggable

  after_save :convert_markdown_to_html, if: :body_markdown_changed?

  belongs_to :featured_image, class_name: "Image"

  validates :slug, uniqueness: true

  scope :published, -> () { where.not(published_at: nil) }
  scope :on_index, -> () { where(show_on_index: true) }

  def slug_candidates
    [:title, [:title, :id]]
  end

  def is_published
    @is_published || (self.published_at ? true : false) 
  end

  def is_published=(value)
    should_be_published = ActiveRecord::Type::Boolean.new.cast(value)
    if should_be_published && self.published_at.nil?
      self.published_at = Time.zone.now
    elsif should_be_published == false && self.published_at
      self.published_at = nil
    end
  end

  def featured_image?
    featured_image && featured_image.media.exists?
  end

  def convert_markdown_to_html
    html = Kramdown::Document.new(body_markdown, {
      syntax_highlighter: :rouge
    }).to_html

    update_columns(body_html: html)
  end
end
