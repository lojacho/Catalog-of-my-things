require_relative '../lib/book'
require 'pry'

describe Book do
  before :each do
    @book = Book.new(publisher: 'pub', cover: 'bad', publish_date: '1111-11-11')
  end
  context 'method unit tests: ' do
    it 'Book.new creates a book object' do
      expect(@book).to be_instance_of(Book)
    end

    it '#can_be_archived?' do
      no_archive = Book.new(publisher: 'pub', cover: 'good', publish_date: Date.today.to_s)
      @book.move_to_archive
      no_archive.move_to_archive
      expect(@book.archived).to be true
      expect(no_archive.archived).to be false
    end

    it '#to_json correct serialization' do
      expect(@book.to_json).to eql("{\"json_class\":\"Book\",\"genre\":null,\"author\":null,\"source\":null,\
\"label\":null,\"publish_date\":\"1111-11-11\",\"publisher\":\"pub\",\"cover_state\":\"bad\"}")
    end
  end
end
