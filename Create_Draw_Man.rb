def draw_man(lives)
  if lives==5
    print "
 +---+-
 |   |
 |
 |
 |
-+----------"
  elsif lives==4
    print "
 +---+-
 |   |
 |   0
 |   |
 |
-+----------"
  elsif lives==3
    print"
 +---+-
 |   |
 |   0
 |   |\\
 |
-+----------"
  elsif lives==2
    print "
 +---+-
 |   |
 |   0
 |  /|\\
 |
-+----------"
  elsif lives==1
    print"
 +---+-
 |   |
 |   0
 |  /|\\
 |    \\
-+----------"
  elsif lives==0
    print "
 +---+-
 |   |
 |   0
 |  /|\\
 |  / \\
-+----------"
  end
end

def display_guess_progress(guessed_letters, game_word)
  game_word.each do |x|
    if guessed_letters.include?(x)
      print x
    else
      print "_ "
    end
  end
  puts
  puts "Letters Guessed  #{guessed_letters.to_s.upcase}"
end

dictionary = File.open('english-dictionary.txt')
dictionary_array = dictionary.readlines
dictionary_array.shuffle!

puts "\nLets PLay Hangman!\n\n"
puts "Type \"start\" to begin a new game\n"
rematch=nil
print "->"
start_game=gets.chomp.downcase.strip
until start_game=="start"
  print "->"
  start_game=gets.chomp.downcase.strip
end

rematch==[]

game_word=dictionary_array.first.chomp.chars.to_a
letters_remaining=game_word.clone

until rematch=="quit"

  alphabet=("a".."z").to_a
  lives=6
  guessed_letters=[]

  puts "Word generated!"
  puts "Lives Remaining: #{lives}"

  while start_game=="start" && lives>0
    draw_man(lives)
    puts
    display_guess_progress(guessed_letters, game_word)
    puts

    puts "Guess a letter: "
    print "-> "
    guess=gets.chomp.downcase.strip

    until alphabet.include?(guess)==true && !guessed_letters.include?(guess)
      puts "INVALID ENTRY"
      puts "Please guess from the available letters"
      print "-> "
      guess=gets.chomp.downcase.strip
      display_guess_progress(guessed_letters, game_word)
    end

    guessed_letters.push(guess)

    if game_word.include?(guess)
      puts "\n\n"
      letters_remaining.delete(guess.downcase)

      if letters_remaining==[]
        puts "CONGRATULATIONS! You got the word #{game_word.to_s.upcase}"
        exit
      end
    else
      lives=lives-1
      puts "WRONG!\n"
    end
  end

  if lives==0
    draw_man(0)
    puts "Sorry The Word Was #{game_word.to_s.upcase}"
    puts puts "Type \"rematch\" to try again\ Or Type \"Quit\" To Quit \n"
    rematch=gets.chomp.downcase.strip
    if rematch=="rematch"

    elsif rematch=="quit"
      exit
    end
  end
end