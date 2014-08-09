class AddDetailsToDemos < ActiveRecord::Migration
  def change
    add_column :demos, :is_image, :boolean
    add_column :demos, :asset_url, :string
  end
end
