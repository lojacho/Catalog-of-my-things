require 'json'

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