class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.column :headline,       :string
      t.column :description,    :text
      t.column :file_name,      :string
      t.column :content_type,   :string
      t.column :other_content,  :text

      t.timestamps
    end

   execute "CREATE TABLE works_rel_works (
           work_id INT,
           rel_work_id INT,
           PRIMARY KEY(work_id, rel_work_id)
         );"
  end

  def self.down
    drop_table :works
   drop_table :works_rel_works
  end
end
