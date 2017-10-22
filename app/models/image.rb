class Image < ApplicationRecord

  attr_accessor :target_class

  validates :image_file_name, presence: true

  if Rails.env.development?
    has_attached_file :image,
                      :styles => { :caption => '450x300#', :thumb => '150x150#' },
                      :url  => '/assets/paperclip/:id/:style.:extension',
                      :path => "#{Rails.root}/public/assets/paperclip/:id/:style.:extension"
  else
    has_attached_file :image,
                      :styles => { :caption => '450x300#', :thumb => '150x150#' },
                      :default_url => '/images/:style/missing.png',
                      :storage => :s3,
                      :bucket => ENV['S3_BUCKET'],
                      :s3_region => ENV['S3_REGION'],
                      :s3_host_name => ENV['S3_HOST'],
                      :s3_permissions => 'public-read',
                      :s3_credentials => "#{Rails.root}/config/s3.yml",
                      :path => '/images/:id/:style.:extension'
  end

  validates_attachment_content_type :image,
                                    :content_type => %W{image/jpg image/jpeg image/png image/x-png image/gif},
                                    :message => '画像以外のファイルが選択されています'

  validates_attachment_size :image, :less_than => 3.megabytes,
                            :message => 'ファイルサイズは3MB以内にしてください'

  def public_url(style = :original)
    if Rails.env.development?
      image.url(style)
    else
      image.s3_object(style).public_url
    end
  end

end
