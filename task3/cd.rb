require_relative "library_item"

# A music CD. The author of a CD is its artist, so `artist` is an
# alias of `author`. The extra properties are the genre and,
# optionally, the number of tracks.
class CD < LibraryItem
  attr_reader :genre, :track_count

  alias_method :artist, :author

  def initialize(title, artist, publication_year, genre, track_count: nil)
    super(title, artist, publication_year)
    @genre = genre
    @track_count = track_count
  end

  def creator_label
    "Artist"
  end

  def display_info
    puts "[CD]"
    super
    puts "Genre: #{genre}"
    puts "Tracks: #{track_count}" if track_count
  end
end