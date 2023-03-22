require_relative './music_album'
require_relative './preserve_music_album'
require_relative './genre'
require 'boolean'

ACTIONS = {
  0 => :exit,
  1 => :list_books,
  2 => :list_music_albums,
  3 => :list_games,
  4 => :list_genres,
  5 => :list_labels,
  6 => :list_authors,
  7 => :add_book,
  8 => :add_music_album,
  9 => :add_game
}.freeze

class App
  def initialize
    @items = { music_album: [] }
  end

  def show_menu
    puts '0) Exit'
    puts '1) List all books'
    puts '2) List all music albums'
    puts '3) List all games'
    puts '4) List all genres'
    puts '5) List all labels'
    puts '6) List all authors'
    puts '7) Add a book'
    puts '8) Add a music album'
    puts '9) Add a game'
    puts 'Choose an option by number:'
  end

  def run
    option = -1
    until option.zero?
      show_menu
      option = gets.chomp.to_i
      if option.between?(0, 9)
        action = ACTIONS[option]
        send(action)
      else
        puts 'Invalid option'
      end
    end
  end

  def exit
    puts 'Thanks for using this app.'
  end

  def add_music_album
    print 'Add genre: '
    genre = gets.chomp.to_s
    print 'Add author: '
    author = gets.chomp.to_s
    print 'Add source: '
    source = gets.chomp.to_s
    print 'Add label: '
    label = gets.chomp.to_s
    print 'Add publish date(yyyy-mm-dd): '
    publish_date = gets.chomp.to_s
    print 'Is it on Spotify(true/false): '
    on_spotify = Boolean(gets.chomp)
    obj_genre = Genre.new(name: genre)
    @items[:music_album].push(MusicAlbum.new(genre: obj_genre, author: author, source: source, label: label,
                                             publish_date: publish_date, on_spotify: on_spotify))
    # p @items[:music_album]
    save_music_album(@items[:music_album])
    puts 'Music Album created successfully'
  end
end
