require 'date'
require 'json'

class Genre
  attr_accessor :name
  attr_reader :items

  def initialize(name: nil, items: [])
    @id = Date.today.jd
    @name = name
    @items = items
  end

  def add_item(item)
    item.genre = self if item.genre.nil?
    @items.push(item)
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'id' => @id,
      'name' => name
    }.to_json(*args)
  end
end
