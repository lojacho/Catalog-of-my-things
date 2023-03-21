require_relative './item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  # args is a hash that captures any additional named arguments not explicitly listed
  def initialize(on_spotify: false, **args)
    super(genre: args[:genre] || nil,
          author: args[:author] || nil,
          source: args[:source] || nil,
          label: args[:label] || nil,
          publish_date: args[:publish_date] || nil)
    @on_spotify = on_spotify
  end

  private

  def can_be_archived?()
    super && @on_spotify
  end
end
