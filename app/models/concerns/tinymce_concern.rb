module TinymceConcern
  extend ActiveSupport::Concern

  def self.set_images_path(tinymce_content)
    # Tinymceのバグ？で、localに画像を保存すると相対パスに変換されてしまうため、
    # それを絶対パスに置換する
    if Rails.env.development? && tinymce_content
      loop do
        break unless tinymce_content.gsub!('src="../', 'src="')
      end
      tinymce_content.gsub!('src="assets', 'src="/assets')
    end
    tinymce_content
  end
end