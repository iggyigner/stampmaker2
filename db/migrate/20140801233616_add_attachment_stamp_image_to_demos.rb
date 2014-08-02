class AddAttachmentStampImageToDemos < ActiveRecord::Migration
  def self.up
    change_table :demos do |t|
      t.attachment :stamp_image
    end
  end

  def self.down
    remove_attachment :demos, :stamp_image
  end
end
