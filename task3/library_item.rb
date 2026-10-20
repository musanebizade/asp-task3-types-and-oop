# Base class for every item of the library catalog.
# It keeps the properties and behavior shared by books, DVDs and CDs.
class LibraryItem
  attr_reader :title, :author, :publication_year

  def initialize(title, author, publication_year)
    raise ArgumentError, "title must not be empty" if title.to_s.strip.empty?
    raise ArgumentError, "author must not be empty" if author.to_s.strip.empty?
    unless publication_year.is_a?(Integer) && publication_year > 0
      raise ArgumentError, "publication year must be a positive integer"
    end

    @title = title
    @author = author
    @publication_year = publication_year
  end

  # Prints the common properties. Derived classes call this with super
  # and then print their own properties.
  def display_info
    puts "Title: #{title}"
    puts "#{creator_label}: #{author}"
    puts "Publication year: #{publication_year}"
  end

  # Label of the main creator. Derived classes change it
  # (director for a DVD, artist for a CD).
  def creator_label
    "Author"
  end

  # Used by the Library class to find items by title.
  def to_s
    "#{self.class.name}: #{title} (#{publication_year})"
  end
end