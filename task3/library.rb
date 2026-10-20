require_relative "library_item"

# Stores and manages a collection of library items of any type.
class Library
  def initialize
    @items = []
  end

  def add_item(item)
    unless item.is_a?(LibraryItem)
      raise ArgumentError, "only LibraryItem objects can be added"
    end

    @items << item
    puts "Added: #{item}"
  end

  # Removes the first item with the given title.
  # Returns the removed item, or nil if there is no such item.
  def remove_item(title)
    item = @items.find { |i| i.title.casecmp?(title) }

    if item
      @items.delete(item)
      puts "Removed: #{item}"
    else
      puts "Item not found: #{title}"
    end

    item
  end

  # Polymorphism: this method does not check the type of the item.
  # It only calls display_info, and Ruby runs the version of the
  # real class (Book, DVD or CD).
  def display_item(item)
    item.display_info
  end

  def display_all_items
    if @items.empty?
      puts "The library is empty."
      return
    end

    puts "Library catalog (#{@items.size} items)"
    puts "-" * 40
    @items.each do |item|
      display_item(item)
      puts "-" * 40
    end
  end
end