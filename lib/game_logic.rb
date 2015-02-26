require 'colorize'

class GameLogic

	attr_accessor :grid_lines, :shot_array, :god_mode

	def initialize
		@shot_array = []
		@god_mode = true
	end

	def initialize_grid
		alpha_line =* ("A".."L")
		grid_coords =* ("a".."l")
		@grid_lines = (0..12).map {|line| line == 0 ? ["    "] + alpha_line : [line.to_s.rjust(4)] + grid_coords}
	end

	def print_hidden_grid 
	
		@grid_lines.map {|line| puts line.map{|char| char.to_s.sub(/[abcdefghijkl*]/," ")}.join(" ")}
	end

	def print_grid
		if god_mode == false
			print_hidden_grid
		else
			@grid_lines.map {|line| puts line.map{|char| char.to_s.sub(/[abcdefghijkl]/," ")}.join(" ")}
		end
	end	

	def parse_coords(coord1,coord2)

		letter_1 = coord1[0].upcase
		letter_2 = coord2[0].upcase
		
		[letter_1.ord, letter_2.ord, coord1.tr('A-z',"").to_i, coord2.tr('A-z',"").to_i]
	end

	def single_coord_parser(coord) 

		letter = coord[0].upcase

		[letter.ord-64, coord.tr('A-z',"").to_i]
	end

	def affirm_shot_coord(coord)
		return :quit if coord.upcase == "Q"
		shot = single_coord_parser(coord)
		if shot[0] > 12 || shot[0] < 1 || shot[1] > 12 || shot[1] < 1
			:shot_out_of_bounds
		else
			shoot(coord)
		end
	end

	def affirm_boat_coords(coord1,coord2, ship_size = 0)
		
		coord_parse = parse_coords(coord1,coord2)
		
		letter_1 = coord_parse[0]
		letter_2 = coord_parse[1]
		number_1 = coord_parse[2]
		number_2 = coord_parse[3]

		if letter_1 > letter_2
			:bad_coord_low_letter_first
		elsif letter_2 > 76 || number_2 > 12
			:bad_coord_bigger_than_grid
		elsif number_1 > number_2
			:bad_coord_low_number_first
		elsif (letter_2 != letter_1) && (number_2 != number_1)
			:bad_coord_ship_must_be_vertical_or_horizontal
		elsif (letter_2 - letter_1) != ship_size-1 && (number_2 - number_1) != ship_size-1
			:bad_coord_wrong_size
		else
			add_ships(letter_1, letter_2, number_1, number_2)
		end 
	end

	def add_ships(letter_1, letter_2, number_1, number_2)
		if letter_1 == letter_2
			start = number_1
			stop = number_2
			
			if deconflict_ships_vertical(start,stop,letter_1) == true
				return :conflict
			end
			
			while stop >= start 
				@grid_lines[start].map!{|space| space.to_s == letter_1.chr.downcase ? "*" : (space)}
				start += 1
			end
		
		elsif number_1 == number_2
			ship_length =* (letter_1 - 64..letter_2 - 64)

			if deconflict_ships_horizontal(ship_length,number_1) == true
				return :conflict
			end
			
			ship_length.map! {|index| @grid_lines[number_1][index] = "*"}
		end
		:success
	end

	def deconflict_ships_vertical(start,stop,letter_1,conflict = false)
		letter_1 -= 64
		start += 1
		while stop >= start
				conflict = true if @grid_lines[start][letter_1] == "*"
				start += 1
				break if conflict == true
		end
		conflict
	end

	def deconflict_ships_horizontal(ship_length,number_1)
		conflict = false
		conflict = ship_length.any? {|index| @grid_lines[number_1][index] == "*"}
	end

	def shoot(coord)
		parsed_shot = single_coord_parser(coord)
		letter = parsed_shot[0]
		number = parsed_shot[1]
		if @grid_lines[number][letter] == "*"
			@grid_lines[number][letter] = "x".red
			:hit
		elsif @grid_lines[number][letter] == "x".red
			:already_hit_here
		else	
			@grid_lines[number][letter] = "o".blue 
			:miss
		end
	end

	def alive_boat_check
		
		alive_boat = @grid_lines.any? {|rows| rows.any?{|boats| boats == "*"}}
	end

	def random_grid_setup(coord1 = "placeholder",coord2 = "placeholder") #NEEDS TEST
		(1..4).each do |ship_size|
			until affirm_boat_coords(coord1,coord2,ship_size+1) == :success
				letter = rand(65..76)
				number = rand(1..12)
				coord1 = letter.chr + number.to_s
				rand(2)%2 == 0 ? coord2 = letter.chr + (number+ship_size).to_s : coord2 = (letter+ship_size).chr + number.to_s
			end
		end
	end

	def random_shot
		coord = rand(65..76).chr + rand(1..12).to_s
		if @shot_array.any?{|shot| shot == coord}
			random_shot
		else 
			@shot_array << coord
			shoot(coord)
		end
	end

end

if __FILE__ == $0
	game = GameLogic.new
	game.initialize_grid
end

