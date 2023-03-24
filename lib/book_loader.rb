require_relative './genre'

def load_books_from_file
  return [] unless File.file?('./data/books.json')

  JSON.parse(File.read('./data/books.json')).map do |book|
    labels = load_labels
    book_label = (
      labels.select { |label| label&.title == book['label']['title'] }[0] ||
      Label.new(title: book['label']['title'], color: book['label']['color'], id: book['label']['id'])
    )
    book_genre = Genre.new(name: book['genre']['name'])

    args = {
      genre: book_genre,
      author: book['author'],
      source: book['source'],
      label: book_label,
      publish_date: book['publish_date']
    }
    Book.new(publisher: book['publisher'], cover: book['cover_state'], **args)
  end
end
