Spree::LineItem.class_eval do
  has_attached_file :image,
                    styles: { mini: '48x48>', small: '100x100>', line_item: '240x240>', large: '600x600>' },
                    default_style: :line_item,
                    url: '/spree/line_items/:id/:style/:basename.:extension',
                    path: ':rails_root/public/spree/line_items/:id/:style/:basename.:extension',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
  validates_attachment :image,
    :presence => true,
    :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif) }
  validate :no_attachment_errors

  private
    
  def no_attachment_errors
    unless image.errors.empty?
      # uncomment this to get rid of the less-than-useful interim messages
      # errors.clear
      errors.add :image, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
      false
    end
  end
end