atom_feed do |feed|
  feed.title("Matan's Works")
  feed.updated(@works.first.created_at)
 
  for work in @works
    feed.entry(work) do |entry|
      entry.title(work.headline)
      entry.content(work.description, :type => 'html')
      entry.updated(work.updated_at) # needed to work with Google Reader.
      entry.icon('http://localhost:3000/images/matan.jpg')
      entry.link( :href => work.image.url(:display),
                  :rel => "enclosure", :type => "image/jpeg"  )
      entry.author do |author|
        author.name('Matan Israeli')
      end
    end
  end
end