class Work < ActiveRecord::Base
  has_and_belongs_to_many  :works,
	 :join_table => 'works_rel_works',
	 :foreign_key => 'rel_work_id',
	 :association_foreign_key => 'work_id',
	 :after_add => :create_reverse_association,
	 :after_remove => :remove_reverse_association

  validates_presence_of :headline,  :description

#  acts_as_fleximage do
#      image_directory   'public/images/works'
#      image_storage_format :jpg
#  end
	has_attached_file :image, :styles => { :display=> "900x440"}
	validates_attachment_content_type :image, :content_type => ['image/jpg', 'image/jpeg', 'image/gif', 'image/png']
	has_attached_file :thumbnail, :styles => { :original=> "80x80#"}
	validates_attachment_content_type :thumbnail, :content_type => ['image/jpg', 'image/jpeg', 'image/gif', 'image/png']

  def rel_works
    self.works
  end

  def related_to(other)
	 self.works.include?(other)
  end

#  def image_file=(input_data)
#	 unless input_data.is_a? String
#		self.file_name	 = input_data.original_filename
#		self.content_type = input_data.content_type.chomp
#		self.binary_data	 = input_data.read
#	 end
#  end


  private
  def create_reverse_association(associated_work)
	 associated_work.rel_works << self unless associated_work.rel_works.include?(self)
  end

  def remove_reverse_association(associated_work)
	 associated_work.rel_works.delete(self) if associated_work.rel_works.include?(self)
  end
end
