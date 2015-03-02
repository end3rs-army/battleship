require_relative './lib/battleship'

class Runner

	attr_accessor :battleship

	def initialize
		@battleship = Battleship.new
	end

end

run = Runner.new
run.battleship.intro