class ContentMagnet < ApplicationRecord
  before_create :assign_token

  has_attached_file :asset,
                    storage: :s3,
                    bucket: Rails.application.secrets.s3_bucket,
                    s3_region: Rails.application.secrets.aws_region,
                    s3_credentials: {
                      access_key_id:  Rails.application.secrets.aws_access_key_id, 
                      secret_access_key: Rails.application.secrets.aws_secret_access_key
                    },
                    s3_permissions: "private",
                    s3_protocol: :https,
                    path: "assets/:id-filename",
                    url: ":s3_domain_url" #needed since we're using us-east-2 region. this avoids the error: The bucket you are attempting to access must be addressed using the specified endpoint.

  validates_attachment_content_type :asset, content_type: ['application/pdf']

  def self.generate_token
    key = nil
    loop do
      key = SecureRandom.hex
      break if ContentMagnet.find_by_token(key).nil?
    end
    key
  end

  def assign_token
    self.token = ContentMagnet.generate_token
  end
end
