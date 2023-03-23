require_relative '../lib/author'

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
end
