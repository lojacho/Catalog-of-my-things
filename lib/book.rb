require 'json'
require_relative './item'

class Book < Item
  attr_accessor :publisher, :cover_state

  # Needs a hash as argument for super
  def initialize(publisher:, cover:, **args)
    super(genre: args[:genre] || nil,
          author: args[:author] || nil,
          source: args[:source] || nil,
          label: args[:label] || nil,
          publish_date: args[:publish_date] || nil)
    @publisher = publisher
    @cover_state = cover
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'genre' => genre,
      'author' => author,
      'source' => source,
      'label' => label,
      'publish_date' => publish_date,
      'publisher' => publisher,
      'cover_state' => cover_state
    }.to_json(*args)
  end

  private

  def can_be_archived?
    super || cover_state == 'bad'
  end
end
