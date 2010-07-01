   ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
   require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
   works = Work.find(:all)
   works.each do |work|     
       #file = File.open(work.file_path)
       #work.image = file
       work.save
    end
