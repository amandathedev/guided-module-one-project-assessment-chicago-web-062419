require "artii"
# require "figlet"

def welcome
  welcome_message = Artii::Base.new
  puts welcome_message.asciify("Welcome!")
  puts "What can I help you with?"
  choices = <<-CHOICE
    - help : displays this help message
    - list : displays a list of songs you can play
    - play : lets you choose a song to play
    - exit : exits this program
CHOICE

  puts choices
end
