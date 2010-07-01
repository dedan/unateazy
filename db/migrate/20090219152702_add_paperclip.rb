class AddPaperclip < ActiveRecord::Migration
  def self.up
	  add_column  :works, :image_file_name, :string
	  add_column  :works, :image_content_type, :string
	  add_column  :works, :image_updated_at, :timestamp
	  add_column  :works, :image_file_size, :integer
	  add_column  :works, :thumbnail_file_name, :string
	  add_column  :works, :thumbnail_content_type, :string
	  add_column  :works, :thumbnail_updated_at, :timestamp
	  add_column  :works, :thumbnail_file_size, :integer
  end

  def self.down
  end
end
