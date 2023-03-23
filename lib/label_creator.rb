def load_labels_from_file
  return [] unless File.file?('./data/labels.json')

  JSON.parse(File.read('./data/labels.json')).map do |label|
    Label.new(id: label['id'], title: label['title'], color: label['color'])
  end
end

def create_new_label
  puts 'Label name: '
  name = gets.chomp.to_s.capitalize
  puts 'Label color: '
  color = gets.chomp.to_s.capitalize
  new_label = Label.new(title: name, color: color)
  print "\nLabel Created Successfuly\n"
  new_label
end
