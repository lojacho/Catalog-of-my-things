require 'date'
require_relative 'item'
class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(multiplayer: nil, last_played_at: nil, **params)
    super(genre: params[:genre] || nil,
          author: params[:author] || nil,
          source: params[:source] || nil,
          label: params[:label] || nil,
          publish_date: params[:publish_date] || '0000-00-00')
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  private

  def can_be_archived?
    super && last_played_at > 2
  end
end
