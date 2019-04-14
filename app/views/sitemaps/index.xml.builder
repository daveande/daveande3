xml.instruct! :xml, :version=>'1.0'
xml.tag! 'urlset', 
  'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9',
  'xmlns:image' => "http://www.google.com/schemas/sitemap-image/1.1" do
  xml.url{
      xml.loc("#{root_url}")
      xml.changefreq("daily")
      xml.priority(1.0)
  }
  xml.url{
      xml.loc("#{posts_url}")
      xml.changefreq("weekly")
      xml.priority(0.8)
  }
  @posts.find_each do |post|
    xml.url {
      xml.loc "#{post_url(post)}"
      xml.changefreq("weekly")
      xml.priority(0.9)
      if post.featured_image
        xml.tag!("image:image") do
          xml.tag!("image:loc", post.featured_image.media(:social))
          xml.tag!("image:caption", post.subtitle)
        end
      end
    }
  end
end

