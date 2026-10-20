require_relative "library_item"

# A DVD. The author of a DVD is its director, so `director` is an
# alias of `author`. The extra properties are the genre and,
# optionally, the duration.
class DVD < LibraryItem
  attr_reader :genre, :duration_minutes

  alias_method :director, :author

  def initialize(title, director, publication_year, genre, duration_minutes: nil)
    super(title, director, publication_year)
    @genre = genre
    @duration_minutes = duration_minutes
  end

  def creator_label
    "Director"
  end

  def display_info
    puts "[DVD]"
    super
    puts "Genre: #{genre}"
    puts "Duration: #{duration_minutes} min" if duration_minutes
  end
end