require_relative '../lib/author'
require_relative '../lib/item'

describe 'Test Author class' do
  author = Author.new(first_name: 'Osvaldo', last_name: 'Barrios')

  it 'takes parameters and returns an author object' do
    expect(author).to be_instance_of(Author)
  end

  it "author first name should be 'Osvaldo'" do
    expect(author.first_name).to eql 'Osvaldo'
  end

  it "author last name should be 'Osvaldo'" do
    expect(author.last_name).to eql 'Barrios'
  end

  it '#add_item adds self to item as well' do
    item = Item.new(publish_date: '2010-10-10')
    author.add_item(item)
    expect(author.items.include?(item)).to be true
  end
end
