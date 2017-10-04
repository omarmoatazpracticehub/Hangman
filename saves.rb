require 'CSV'

class Save
	#CSV sturcture: id, guess, guesses, word
	def self.read(path)
		saved_games = []
		saved_games = CSV.parse(File.read(path))
		# puts saved_games[0]
	end
	def self.write(path, guess, guesses, word)
		CSV.open("saved_games.csv", "a+") do |csv|
			csv << [guess, guesses, word]
		end
	end
end