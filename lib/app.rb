class App
  def initialize
    @items = {}
  end
  def run
    loop do 
    puts '0) Exit'
    puts '1) List all books'
    puts '2) List all music albums'
    puts '3) List all games'
    puts '4) List all genres'
    puts '5) List all labels'
    puts '6) List all authors'
    puts '7) Add a book'
    puts '8) Add a music album'
    puts '9) Add a game'
    puts 'Choose an option by number:'
    option = gets.chomp.to_i
    action (option)
    while not option.zero?
  end

  def action(num)
   case num 
   when 1
    false
   when 2 
     false
   when 3 
     false
   when 4 
     false
   when 5 
     false
   when 6
     false
   when 7 
     false
   when 8 
     false
   when 9
     false
   when 0
    puts 'thanks for use this app'
   else
    puts ' this option is invalid'    
  end
  end
end