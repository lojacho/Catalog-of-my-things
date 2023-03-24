require_relative '../lib/music_album'

describe MusicAlbum do
  before :each do
    @music_album = MusicAlbum.new(on_spotify: false, publish_date: '2022-02-22')
  end
  context 'When testing MusicAlbum class: ' do
    it 'MusicAlbum.new creates a music album object' do
      expect(@music_album).to be_instance_of(MusicAlbum)
    end

    it '#can_be_archived?' do
      no_archive = MusicAlbum.new(on_spotify: true, publish_date: '2000-02-22')
      expect(@music_album.move_to_archive).to be false
      expect(no_archive.move_to_archive).to be true
    end
  end
end
