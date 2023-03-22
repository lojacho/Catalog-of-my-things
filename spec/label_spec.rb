require_relative '../lib/label'
require_relative '../lib/item'

describe Label do
  before :each do
    @label = Label.new(title: 'new', color: 'red')
  end
  context 'method unit tests: ' do
    it 'Label.new creates a label object' do
      expect(@label).to be_instance_of(Label)
    end

    it '#add_item adds self to item as well' do
      item = Item.new(publish_date: '1111-11-11')
      @label.add_item(item)
      expect(@label.items.include?(item)).to be true
      expect(item.label).to eq(@label)
    end

    it '#to_json correct serialization' do
      expect(@label.to_json).to eql("{\"json_class\":\"Label\",\"id\":#{@label.id},\
\"title\":\"new\",\"color\":\"red\"}")
    end
  end
end
