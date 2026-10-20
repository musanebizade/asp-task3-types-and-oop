require_relative "library_item"

# A printed book. The extra property is the genre.
class Book < LibraryItem
  attr_reader :genre

  def initialize(title, author, publication_year, genre)
    super(title, author, publication_year)
    @genre = genre
  end

  def display_info
    puts "[Book]"
    super
    puts "Genre: #{genre}"
  end
end