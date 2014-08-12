class AddAssetUrlToDemos < ActiveRecord::Migration
  def change
    add_column :demos, :asset_url, :string
  end
end
