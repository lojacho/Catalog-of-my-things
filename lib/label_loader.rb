def load_labels_from_file
  return [] unless File.file?('labels.json')

  JSON.parse(File.read('labels.json')).map do |label|
    Label.new(id: label['id'], title: label['title'], color: label['color'])
  end
end
