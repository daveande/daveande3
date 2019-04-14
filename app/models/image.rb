class Image < ApplicationRecord
  has_attached_file :media,
                    storage: :s3,
                    bucket: Rails.application.secrets.s3_bucket,
                    s3_region: Rails.application.secrets.aws_region,
                    s3_credentials: {
                      access_key_id:  Rails.application.secrets.aws_access_key_id, 
                      secret_access_key: Rails.application.secrets.aws_secret_access_key
                    },
                    source_file_options: {:all => '-auto-orient'},
                    s3_permissions: "public-read",
                    s3_protocol: :https,
                    path: "images/:style/:id-:filename",
                    styles: {
                      thumb: "150x150#",
                      logo: "200x",
                      social: "1024x512#",
                      large: "1800x"
                    },
                    url: ":s3_domain_url" #needed since we're using us-east-2 region. this avoids the error: The bucket you are attempting to access must be addressed using the specified endpoint.

  validates_attachment_content_type :media, content_type: [
    'image/jpeg', 
    'image/png', 
    'image/gif', 
    'image/tiff'
  ]

  
end
