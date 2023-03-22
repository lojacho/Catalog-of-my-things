require 'date'
require_relative 'item'
class Game < Item
  attr_accessor :multiplayer, :last_played_at
  attr_reader :archived

  def initialize(multiplayer: nil, last_played_at: nil, **params)
    super(genre: params[:genre] || nil,
          author: params[:author] || nil,
          source: params[:source] || nil,
          label: params[:label] || nil,
          publish_date: params[:publish_date] || '0001-01-01')
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at)
  end

  private

  def can_be_archived?
    super && (((Date.today - last_played_at).to_i / 365)  > 2)
  end
end
