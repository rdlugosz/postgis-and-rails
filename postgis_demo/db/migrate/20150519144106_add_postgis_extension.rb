class AddPostgisExtension < ActiveRecord::Migration
  def change
    enable_extension :postgis
  end
end
