require 'boolean'
require 'json'
require 'pry'
require_relative './music_album'
require_relative './genre'
require_relative './book'
require_relative './label'
require_relative './preserve_music_album'
require_relative './book_loader'
require_relative './label_creator'
require_relative './game'
require_relative './author'

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
      music_album: [],
      labels: load_labels,
      books: load_books,
      game: [],
      author: []
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
    save_books
    save_labels
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
    puts 'Pick a label or 0 to create a new one:  '
    option = gets.chomp.to_i
    label = create_label if option.zero?
    label = @items[:labels][option - 1] unless option.zero?
    args = { publish_date: date, label: label }
    book = Book.new(publisher: publisher, cover: cover_state, **args)
    @items[:books].push(book)
    print "\nBook Created Successfuly\nEnter to continue..."
    gets.chomp
  end

  def add_game
    puts '\n*- Add a game -*\n'
    print 'Is it a multiplayer game? [Y/N]: '
    multiplayer = gets.chomp.to_s.downcase == 'y'
    print 'When was it last played at? [yyyy-mm-dd] '
    last_played_at = gets.chomp.to_s
    puts 'Publish date [yyyy-mm-dd]: '
    date = gets.chomp.to_s
    params = { publish_date: date }
    game = Game.new(multiplayer: multiplayer, last_played_at:last_played_at, **params )
    @items[:game].push(game)
    puts 'Game successfully created!'
  end

  def create_label
    @items[:labels].push(create_new_label)
  end

  def list_labels
    if @items[:labels].empty?
      puts "\n** No labels found **\n"
    else
      puts "\n=========== Labels ==========="
      @items[:labels].each_with_index { |label, i| puts " #{i + 1}. \"#{label.title}\" - #{label.color}" }
      puts "------------------------------\n"
    end
  end

  def add_author_ui
    puts '- Authors -'
    list_all_authors
    print "\nSelect an author [number on the list] or create a new author [0]: "
    author = gets.chomp
    select_create_author(author)
  end

  def create_author
    puts "\n*- New Author -*"
    print 'First name: '
    first_name = gets.chomp
    print 'Last name: '
    last_name = gets.chomp
    Author.new(first_name, last_name)
  end

  def list_authors
    if @items[:author].empty?
      puts 'Authors list is empty, please create a new one' 
    else
      @items[:author].each_with_index do |author, index|
        puts "#{index + 1} - First name: #{author.first_name} Last name: #{author.last_name}"
      end
    end
  end

  def list_games
    if @items[:game].empty?
      puts 'Game list is empty'
    else
      @items[:game].each_with_index do |game, index|
        puts "[#{index}] - Publish date: #{game.publish_date} Last played: #{game.last_played_at}
      Multiplayer: #{game.multiplayer}\n"
      end
    end
  end

  def save_games
    File.open('games.json')
  end

  def list_books
    if @items[:books].empty?
      puts "\n** No books found **\n"
    else
      puts "\n=========== Books ==========="
      @items[:books].each do |book|
        puts "Author: #{book.author}\
 | Publisher: #{book.publisher}\
 | Genre: #{book.genre}\
 | Label: #{book.label.title}\
 | Cover state: #{book.cover_state.capitalize}"
      end
      puts "------------------------------\n"
    end
    puts "\nEnter to continue..."
    gets.chomp
  end

  def save_books
    File.write('books.json', JSON.generate(@items[:books]))
  end

  def save_labels
    File.write('labels.json', JSON.generate(@items[:labels]))
  end

  def load_books
    load_books_from_file
  end

  def load_labels
    load_labels_from_file
  end

  def list_music_albums
    @items[:music_album] = read_music_album(@items[:music_album])
    if @items[:music_album][0]
      @items[:music_album].each do |album|
        puts "Genre: #{album.genre.name}, " \
             "Author: #{album.author}, " \
             "Source: #{album.source}, " \
             "Label: #{album.label}, " \
             "Publish Date: #{album.publish_date}, " \
             "On Spotify: #{album.on_spotify}"
      end
    else
      puts 'There are not any music album to display'
    end
  end

  def list_genres
    @items[:music_album] = read_music_album(@items[:music_album])
    if @items[:music_album][0]
      displayed_genres = []
      @items[:music_album].each do |album|
        genre_name = album.genre.name
        unless displayed_genres.include?(genre_name)
          puts "Genre: \"#{genre_name}\""
          displayed_genres << genre_name
        end
      end
    else
      puts 'There is not any genre to display'
    end
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
    save_music_album(@items[:music_album])
    puts 'Music Album created successfully'
  end
end
