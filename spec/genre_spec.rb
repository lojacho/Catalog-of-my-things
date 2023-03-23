require_relative '../lib/genre'

describe Genre do
  before :each do
    @genre = Genre.new(name: 'San Juanitos')
  end
  context 'When testing Genre class: ' do
    it 'Genre.new creates a genre object' do
      expect(@genre).to be_instance_of(Genre)
    end

    it '#add_item adds self to item as well' do
      item = double('item')
      allow(item).to receive(:genre).and_return(@genre)
      @genre.add_item(item)
      expect(@genre.items.include?(item)).to be true
      expect(item.genre).to eq(@genre)
    end
  end
end
