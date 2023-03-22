require 'date'

class Item
  attr_accessor :genre, :author, :source, :label, :publish_date

  def initialize(genre: nil, author: nil, source: nil, label: nil, publish_date: '')
    @id = Time.now.to_i
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = Date.parse(publish_date) # format: yyyy-mm-dd
    @archived = false
    genre&.add_item(self)
    label&.add_item(self)
  end

  def move_to_archive()
    @archived = can_be_archived?
  end

  private

  def can_be_archived?()
    ((Date.today - publish_date).to_i / 365) > 10
  end
end
