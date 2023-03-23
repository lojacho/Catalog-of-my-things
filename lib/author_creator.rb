def load_authors_from_file
    return [] unless File.file?('./data/authors.json')
  
    JSON.parse(File.read('./data/authors.json')).map do |author|
      Author.new(first_name:author['first_name'], last_name: author['last_name'])
    end
  end
