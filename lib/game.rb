require 'date'
require_relative 'item'
class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(genre:nil, author:nil, source:nil, label:nil, publish_date:'2003-12-02', multiplayer:nil, last_played_at: nil)
    super(genre:genre, author:author, source:source, label:label, publish_date:publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end
  
  private
  def can_be_archived?
    super && last_played_at > 2
  end
end
