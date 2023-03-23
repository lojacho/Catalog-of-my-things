require 'json'
class Author
  attr_accessor :first_name, :last_name
  attr_reader :items, :id

  def initialize(first_name: nil, last_name: nil)
    @id = Random.rand(1..1000)
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def to_json(*parms)
    {
      JSON.create_id => self.class.name,
      'id' => @id,
      'first_name' => first_name,
      'last_name' => last_name
    }.to_json(*parms)
  end

  def add_item(item)
    @items.push(item)
    item&.author = self unless item&.author == self
  end
end
