require_relative "./messages"
require_relative "./game_logic"

class Battleship

	attr_accessor :messages, :enemy, :you

	def initialize
		@messages = Messages.new
		@enemy = GameLogic.new
		@you = GameLogic.new
		clear
		puts messages.maximize_experience
		sleep(3)
	end

	def intro
		
		clear

		puts messages.title
		puts messages.uss_turing
		puts messages.menu

		input = user_input

		case input 
			when "p" then game_play
			when "q" then quit 
			when "i" then instructions
			else intro
		end
	end

	def quit
		puts @messages.quit
		sleep(3)
		clear
	end

	def clear

		system "clear"
	end

	def instructions
		clear
		puts messages.instructions
		input = gets.chomp.downcase
		if input == "r"
			intro
		else
			instructions
		end
	end

	def game_play(result = :blank)
		setup_game
		while you.alive_boat_check && enemy.alive_boat_check	
			dynamic_display(:you_turn)
			puts messages.take_a_shot
			result = enemy.affirm_shot_coord(user_input)
			break if result == :quit
			dynamic_display(result)
			computer_sequence if enemy.alive_boat_check
		end
		game_over(result)
	end

	def user_input
		input = gets.chomp.downcase
		input = " " if input == ""
		enemy.god_mode = true if input == "god"
		input
	end

	def dynamic_display(result = :one_line)
		clear
		puts messages.title
		puts messages.send(result)
		puts messages.enemy_grid
		enemy.print_grid
		puts messages.your_grid
		you.print_grid
		puts messages.header
	end

	def setup_game
		clear
		puts messages.title
		puts messages.setup_options
		input = gets.chomp.downcase

		
		enemy.initialize_grid
		enemy.random_grid_setup
		enemy.god_mode = false

		
		you.initialize_grid

		case input
			when "a" then you.random_grid_setup
			when "m" then manual_setup
			else setup_game
		end  
	end

	def manual_setup(result = :blank)
		clear
		(2..5).each do |ship_size|
			loop do
				clear
				puts messages.grid_setup
				puts messages.send(result)
				puts messages.your_grid
				you.print_grid
				puts messages.enter_coord_1(ship_size)
				coord1 = user_input
				puts messages.enter_coord_2(ship_size)
				coord2 = user_input
				result = you.affirm_boat_coords(coord1,coord2,ship_size)
				break if result == :success
			end
		end
	end

	def game_over(result = :blank)
		dynamic_display
		dynamic_display(:win) if you.alive_boat_check
		dynamic_display(:lose) if enemy.alive_boat_check
		dynamic_display(:quit) if result == :quit 
		sleep(3)
		clear
		maximize_message = false
		intro if result != :quit
	end

	def computer_sequence
		sleep(1)
		dynamic_display(:computer_turn)
		sleep(1)
		result = you.random_shot
		dynamic_display(result)
		sleep(1)
	end
end

if __FILE__ == $0
	play = Battleship.new
	play.intro
end