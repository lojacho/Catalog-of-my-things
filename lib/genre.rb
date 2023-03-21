require 'date'

class Genre
  attr_accessor :name

  def initialize(name: nil, items: [])
    @id = Date.today.to_i
    @name = name
    @items = items
  end

  def add_item(item)
    @items.push(item)
  end
end
