atom_feed do |feed|
  feed.title("DjouxTech articles")
  feed.updated @pages.maximum(:publish_at)

  @pages.each do |page|
    feed_entry_options = {
      published: page.publish_at, 
      updated:   page.publish_at
    }

    feed.entry page, feed_entry_options do |entry|
      entry.title(page.title)
      entry.content(page.summary, :type => 'html')
      entry.author do |author|
        author.name(page.user.name)
      end
    end
  end

end