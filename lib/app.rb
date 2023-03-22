require 'boolean'
require 'json'
require 'pry'
require_relative './music_album'
require_relative './preserve_music_album'
require_relative './genre'
require_relative './book'
require_relative './label'

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
      books: load_books
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

  def create_label()
    puts 'Label name: '
    name = gets.chomp.to_s.capitalize
    puts 'Label color: '
    color = gets.chomp.to_s.capitalize
    new_label = Label.new(title: name, color: color)
    @items[:labels].push(new_label)
    print "\nLabel Created Successfuly\n"
    new_label
  end

  def list_labels
    if @items[:labels].empty?
      puts "\n** No labels found **\n"
    else
      @items[:labels].each_with_index { |label, i| puts "#{i + 1}) #{label.title}" }
    end
  end

  def list_books
    if @items[:books].empty?
      puts "\n** No books found **\n"
    else
      @items[:books].each do |book|
        puts "Publisher: #{book.publisher}\nCover state: #{book.cover_state}\nLabel: #{book.label.title}"
      end
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
    return [] unless File.file?('books.json')

    JSON.parse(File.read('books.json')).map do |book|
      labels = load_labels
      book_label = (
        labels.select { |label| label&.title == book['label']['title'] }[0] ||
        Label.new(title: book['label']['title'], color: book['label']['color'], id: book['label']['id'])
      )

      args = {
        genre: book['genre'],
        author: book['author'],
        source: book['source'],
        label: book_label,
        publish_date: book['publish_date']
      }
      Book.new(publisher: book['publisher'], cover: book['cover_state'], **args)
    end
  end

  def load_labels
    return [] unless File.file?('labels.json')

    JSON.parse(File.read('labels.json')).map do |label|
      Label.new(id: label['id'], title: label['title'], color: label['color'])
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
