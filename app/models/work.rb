class Work < ActiveRecord::Base
  has_and_belongs_to_many  :works,
   :join_table => 'works_rel_works',
   :foreign_key => 'rel_work_id',
   :association_foreign_key => 'work_id',
   :after_add => :create_reverse_association,
   :after_remove => :remove_reverse_association

  validates_presence_of :headline,  :description
  
  # Paperclip plugin (used for upload stuff and thumbnail)
  has_attached_file :image, :styles => { 
    :display=> "900x440",                                     # normal size view
    :thumb => "80x80#" }                                      # thumbnail view
  validates_attachment_content_type :image, 
    :content_type => ['image/jpg', 'image/jpeg', 'image/gif', 'image/png']

  # give related works
  def rel_works
    self.works
  end

  # is the current work related to another one?
  def related_to(other)
   self.works.include?(other)
  end

  # make the relation symmetric
  private
  def create_reverse_association(associated_work)
   associated_work.rel_works << self unless associated_work.rel_works.include?(self)
  end

  def remove_reverse_association(associated_work)
   associated_work.rel_works.delete(self) if associated_work.rel_works.include?(self)
  end
end
