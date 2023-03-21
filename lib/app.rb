require_relative './book'
require 'pry'

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
    @items = {
      books: [],
    }
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

  def add_book
    puts 'Input publisher: '
    publisher = gets.chomp.to_s
    puts 'Cover state [1 = good, 2 = bad]:  '
    cover_state = gets.chomp.to_i
    cover_state = 'bad' if cover_state == 2
    cover_state = 'good' unless cover_state == 'bad'
    puts 'Publish date [yyyy-mm-dd]: '
    date = gets.chomp.to_s
    args = { publish_date: date }
    book = Book.new(publisher: publisher, cover: cover_state, **args)
    @items[:books].push(book)
  end

  
end
