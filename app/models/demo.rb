class Demo < ActiveRecord::Base
	has_attached_file :stamp_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :stamp_image, :content_type => /\Aimage\/.*\Z/
end
