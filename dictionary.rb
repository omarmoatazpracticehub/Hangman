class Dictionary
	def self.load_file(path)
		@@dictionary = File.readlines(path)
	end
	def self.random_word (range_start, range_end)
		temp_word = @@dictionary.sample
		while((temp_word.length.between?(range_start, range_end)) == false)
			temp_word = @@dictionary.sample
		end
		return temp_word
	end
end