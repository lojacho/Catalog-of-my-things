require 'date'

class Genre
  attr_accessor :name

  def initialize(name: nil, items: [])
    @id = Date.today.jd
    @name = name
    @items = items
  end

  def add_item(item)
    item.genre = self if item.genre.nil?
    @items.push(item)
  end
end
