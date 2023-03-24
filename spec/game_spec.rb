require_relative '../lib/game'
require_relative '../lib/item'

describe 'Test Game class' do
  game = Game.new(multiplayer: false, last_played_at: '2001-05-02')

  it 'takes parameters and returns a game object' do
    expect(game).to be_instance_of(Game)
  end

  it 'takes parameters and returns a game object which is instance of Item' do
    expect(game).to be_kind_of(Item)
  end

  it 'games can_be_archived? should be true' do
    game.move_to_archive
    expect(game.archived).to be true
  end

  it 'game multiplayer should be false' do
    expect(game.multiplayer).to be false
  end
end
