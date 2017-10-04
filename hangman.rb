require_relative "dictionary.rb"
require_relative "saves.rb"

class Hangman
	def initialize
		@max_guesses = 9
		@guess = ""
		@guesses = 0
	end
	def play_game
		puts "Would like to load from a file?"
		puts "1. Yes\n2. No"
		decision = gets.chomp.to_i
		if decision.to_i == 1
			saved_games = Save.read("saved_games.csv")
			saved_games.each_with_index do |element, index|
				print "#{index}. #{element[0]} #{element[1]}\n"
			end
			choice = gets.chomp.to_i
			load_game = CSV.parse(File.read('saved_games.csv'))
			@guess = load_game[choice][0]
			@guesses = load_game[choice][1].to_i
			@word = load_game[choice][2]
		elsif decision.to_i == 2
			Dictionary.load_file("dictionary.txt")
			@word = Dictionary.random_word(5,12)
			@word.downcase!
			@word.chomp!
			@guess = "_" * @word.length
			puts "Game has started..."
		end
		game_loop
	end
	private
	def check_guess(input)
		found = false
		@word.split("").each_with_index do |char, index|
			if char == input
				@guess[index] = char
				found = true
			end
		end
		return found
	end
	def game_loop
		while(check_end == false)
			puts @guess
			@saved = false
			input = gets.chomp
			if input == "_"
				puts "game saved"
				@saved = true
				Save.write("saved_games.csv", @guess, @guesses, @word)
				next
			end
			found = check_guess(input)
			if found == false
				@guesses += 1
				puts "You have #{@max_guesses - @guesses} guesses left"
			else
				puts "You have guessed successfully"
			end
		end
	end
	def check_end
		if @saved == true
			return true
		elsif @word == @guess
			puts "You've gotten away with it this time! Next time, I wouldn't be so sure"
			return true
		elsif @guesses >= @max_guesses
			puts "Defendant has been found guilty and is sentenced to death by hanging."
			return true
		else
			return false
		end
	end
end

h = Hangman.new
h.play_game