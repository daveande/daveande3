module SeoMetaTagsHelper

  def default_content(tag_name)
    case tag_name
      when :title then "daveande"
      when :description then "Thoughts on Ruby on Rails and general web development"
      when :keywords then "daveande, ruby on rails blog, everclimb"
      else "daveande"
    end
  end

  def set_meta_tag(tag_name, content)
    content_for tag_name do
      content.blank? ? default_content(tag_name) : content
    end
  end
end
