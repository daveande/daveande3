namespace :resources do

  desc "import csv"
  task :import_from_file, [:file_url] => :environment do |t, args|
    file_str = open(args[:file_url]).read
    csv_str = file_str.encode("UTF-8", invalid: :replace)
    csv_str = CSV.parse(csv_str, headers: true)
    csv_str.each_with_index do |row, i|
      row = row.to_hash
      puts i+1
      Resource.create!(
        resource_type: row["resource_type"],
        title: row["title"],
        description: row["description"],
        url: row["url"],
        price: row["price"],
        first_name: row["first_name"],
        last_name: row["last_name"],
        company_name: row["company_name"],
        seo_title: row["title"],
        meta_description: row["description"],
        meta_keywords: "freelancer resources, freelancer books, freelancer tools, freelancer courses, everclimb"
      )
    end
  end
end
