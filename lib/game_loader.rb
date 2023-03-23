def load_games_from_file
  return [] unless File.file?('./data/games.json')

  JSON.parse(File.read('./data/games.json')).map do |game|
    authors = load_authors_from_file
    author1 = (
     authors.select { |author| author&.first_name == game['author']['first_name'] }[0] ||
     Author.new(first_name: game['author']['first_name'], last_name: game['author']['last_name'])
   )

    args = {
      genre: game['genre'],
      author: author1,
      source: game['source'],
      label: game['label'],
      publish_date: game['publish_date']
    }
    Game.new(multiplayer: game['multiplayer'], last_played_at: game['last_played_at'], **args)
  end
end
