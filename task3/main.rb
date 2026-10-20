require_relative "book"
require_relative "dvd"
require_relative "cd"
require_relative "library"

# Create instances of different library items
book = Book.new("Concepts of Programming Languages", "Robert Sebesta", 2015, "Programming")
dvd = DVD.new("Inception", "Christopher Nolan", 2010, "Science Fiction")
cd = CD.new("A Day at the Races", "Queen", 1976, "Rock")

# Display items individually
book.display_info
dvd.display_info
cd.display_info

puts

# Create a library and add items to it
library = Library.new
library.add_item(book)
library.add_item(dvd)
library.add_item(cd)

puts

# Display information about all items in the library
library.display_all_items

puts

# Remove an item and display the catalog again
library.remove_item("Inception")
library.remove_item("Unknown title")

puts

library.display_all_items