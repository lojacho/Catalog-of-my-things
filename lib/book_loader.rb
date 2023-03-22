def load_books_from_file
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
