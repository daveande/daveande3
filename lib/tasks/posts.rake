namespace :posts do

  desc "import jekyll posts"
  task :import => :environment do
    Dir.foreach("/Users/daveande/everclimb/daveande-jekyll/_posts") do |f|
      unless [".","..",".DS_Store"].include?(f)
        puts "importing #{f}"
        f = File.read("/Users/daveande/everclimb/daveande-jekyll/_posts/#{f}")
        front_matter = YAML.load(f.split("---")[1])
        Post.create!(
          title: front_matter["title"],
          subtitle: (ActionView::Base.full_sanitizer.sanitize(f.split("---").last.lstrip).first(95) + "..."),
          created_at: front_matter["date"],
          updated_at: front_matter["modified_time"],
          published_at: front_matter["date"],
          body_html:  f.split("---").last.lstrip,
          seo_title: (front_matter["title"].first(50) rescue nil),
          meta_description: ActionView::Base.full_sanitizer.sanitize(f.split("---").last.lstrip).first(100),
          meta_keywords: (front_matter["tags"].join(", ") rescue nil),
          tag_list: (front_matter["tags"].join(", ") rescue nil)
        )
      end
    end
  end
end
