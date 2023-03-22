require 'json'

class Label
  attr_accessor :title, :color

  def initialize(title:, color:, items: [], id: Time.now.to_i)
    @id = id
    @title = title
    @color = color
    @items = items
  end

  def add_item(item)
    @items.push(item)
    item&.label = self unless item&.label == self
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'id' => @id,
      'title' => title,
      'color' => color
    }.to_json(*args)
  end
end
