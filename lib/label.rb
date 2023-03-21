class Label
  attr_accessor :title, :color

  def initialize(title:, color:, items: [])
    @id = Time.now.to_i
    @title = title
    @color = color
    @items = items
  end

  def add_item(item)
    @items.push(item)
    item&.label = self unless item&.label == self
  end
end
