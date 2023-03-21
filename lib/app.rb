require_relative './book'
require_relative './label'
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
      labels: []
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
    list_labels
    puts 'Pick label [0 = new label]:  '
    option = gets.chomp.to_i
    label = create_label if option.zero?
    label = @items[:labels][option - 1] unless option.zero?
    args = { publish_date: date, label: label }
    book = Book.new(publisher: publisher, cover: cover_state, **args)
    @items[:books].push(book)
  end

  def create_label()
    puts 'Label name: '
    name = gets.chomp.to_s.capitalize
    puts 'Label color: '
    color = gets.chomp.to_s.capitalize
    Label.new(title: name, color: color)
  end

  def list_labels
    if @items[:labels].empty?
      puts '** No labels found **'
    else
      @items[:labels].each_with_index { |label, i| puts "#{i+1}) #{label.title}" }
    end
  end

  def list_books
    if @items[:books].empty?
      puts '** No books found **'
    else
      @items[:books].each do |book|
        puts "Publisher: #{book.publisher}\nCover state: #{book.cover_state}\nLabel: #{book.label}"
      end
    end
  end

  def save_books
    File.open('books.json')
  end
end
