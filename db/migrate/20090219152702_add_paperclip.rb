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
	  remove_column  :works, :image_file_name       
	  remove_column  :works, :image_content_type      
	  remove_column  :works, :image_updated_at        
	  remove_column  :works, :image_file_size         
	  remove_column  :works, :thumbnail_file_name     
	  remove_column  :works, :thumbnail_content_type  
	  remove_column  :works, :thumbnail_updated_at    
	  remove_column  :works, :thumbnail_file_size     
  end
end
