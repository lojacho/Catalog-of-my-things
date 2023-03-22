require 'json'
require_relative './genre'

def save_music_album(music_album)
  albums = music_album.map do |album|
    [
      album.genre.name,
      album.author,
      album.source,
      album.label,
      album.publish_date,
      album.on_spotify
    ]
  end
  albums_json = JSON.generate(albums)
  File.write('albums.json', albums_json)
end

def read_music_album(music_album)
  File.write('albums.json', '') unless File.exist?('./albums.json')
  albums_data = File.read('./albums.json')
  if albums_data.strip.empty?
    music_album = []
  elsif music_album.empty?
    albums_data = JSON.parse(albums_data)
    albums_data.each do |album|
      obj_genre = Genre.new(name: album[0])
      music_album.push(MusicAlbum.new(genre: obj_genre, author: album[1], source: album[2], label: album[3],
                                      publish_date: album[4], on_spotify: album[5]))
    end
  end
  music_album
end
