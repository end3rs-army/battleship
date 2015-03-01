require 'colorize'

class Messages

	def center(string = "")
		string.center(37)
	end


	def title
		"======= B A T T L E   S H I P ======="
	end

	def menu
		["\n\n",
		 "    M E N U\n".center(37), 
		 center("  (p)lay  (q)uit  (i)nstructions")]
	end

	def grid_setup
		["==== S E T   Y O U R   S H I P S ====",
		 "\n",
		 center("[example coordinate: 'A1']")]
	end

	def instructions
		["====== I N S T R U C T I O N S ======",
		 "\n",
		 center("MANUALLY SET BOATS"),
		 "\n",
		 " You will be prompted for a 1st",
		 " coordinate followed by a prompt",
		 " for an 'end' coordinate. The format",
		 " for each coordinate is letter and",
		 " then number (e.g. A1). The first",
		 " coordinate must be an earlier letter",
		 " and lower number than the 'end'",
		 " coordinate (e.g. A1,B1 or A1,A3).",
		 " If you type a bad coordinate you",
		 " will be prompted to enter a new on",
		 "\n",
		 center("SHOOTING"),
		 "\n",
		 " During game play you will be prompted",
		 " to enter a coordinate to shoot at. The",
		 " format for each coordinate is a letter",
		 " and then a number (e.g. A1). IF it is a",
		 " hit you will see a red 'x' on the enemy's",
		 " grid. If it is a miss you will see a blue",
		 " 'o' on the enemy's grid. Good luck!",
		 "\n",
		 center("WINNING / LOSING"),
		 "\n",
		 " If you destroy every one of the enemy ships",
		 " before all of yours are destroyed you win!",
		 " If the enemy destroys all of your ships first",
		 " you lose. DON'T LOSE!!",
		 "\n",
		 center("GOD MODE"),
		 "\n",
		 " If you enter 'GOD' at any prompt during the",
		 " game you will be given 'God mode' and can see",
		 " all of the enemy ships!",
		 "\n\n",
		 center("(r)eturn to go back to menu")]
	end

	def enemy_grid
		"\n-------- E N E M Y   G R I D --------\n\n"
	end

	def your_grid
		"\n--------- Y O U R   G R I D ---------\n\n"
	end

	def header
		"\n\n====================================="
	end

	def take_a_shot
		["\n",
		 center("ENTER COORDINATE TO SHOOT AT (e.g. A1):").green,
		 center("[or (q)uit]").green]
	end
	
	def quit
		["\n",
		 center("YOU ARE A QUITTER!!!").red]
	end

	def setup_options
		["\n\n",
		 center("Time to set your ships!!"),
		 "\n\n",
		 center("PRESS: (m)anual setup  (a)uto setup")]
	end
	
	def enter_coord_1(ship_size)
		["\n",
		 "Enter 1st coordinate for #{ship_size} unit ship:".green]
	end

	def enter_coord_2(ship_size)
		["\n",
		 "Enter end coordinate for #{ship_size} unit ship:".green]
	end
	
	def bad_coord_low_letter_first
		["\n",
		 center("Bad coordinate!").red,
		 center("Enter earlier letter first.").red,
		 center("(e.g. A before B)").red]
	end

	def bad_coord_low_number_first
		["\n",
		 center("Bad coordinate!").red,
		 center("Enter lower number first.").red, 
		 center("(e.g. 1 before 2)").red]
	end

	def bad_coord_wrong_size
		["\n",
		 center("Bad coordinate!").red, 
		 center("Ship size not correct").red]
	end

	def bad_coord_bigger_than_grid
		["\n",
		 center("Bad coordinate!").red, 
		 center("Outside of the grid.").red]
	end

	def bad_coord_ship_must_be_vertical_or_horizontal
		["\n",
		 center("Bad coordinate!").red, 
		 center("Ship must be vertical or horizontal.").red]
	end

	def already_hit_here
		["\n",
		 center("You already hit that coordinate!"),
		 center("what a waste...")]
	end

	def conflict
		["\n",
		 center("You already have a ship there!").red,
		 "\n"]
	end

	def shot_out_of_bounds
		["\n",
		 center("*** T O T A L   M I S S ***")]
	end

	def hit
		["\n",
		 center("*** D I R E C T   H I T ***")]
	end

	def miss
		["\n",
		 center("*** M I S S ***")]
	end

	def blank
		" "
	end

	def success
		""
	end

	def one_line
		"\n"
	end

	def win
	 	["\n",
	 	 center("WINNER!!").green,
	 	 center("YOU SUNK MY BATTLESHIP").green]
	end

	def lose
		["\n",
		 center("LOSER!!").red,
		 center("ALL YOUR BASE ARE BELONG TO US.").red,
		 "\n"]
	end

	def computer_turn
		["\n",
		 center("E N E M Y   S H O O T I N G").red]
	end

	def you_turn
		["\n",
		 center("Y O U R   T U R N").green]
	end

	def maximize_experience
		["\n\n\n",
		 center("FOR THE BEST PLAYING EXPERIENCE"),
		 "\n\n",
		 center("MAXIMIZE TERMINAL WINDOW")]
	end

	def uss_turing

"\n\n\n                    ( )
                    _|__
                _  |____|  _
           _===| | |    | | |==  _
       ===| |.----------------. | |==
   <------'   .  .  .  .  .  .'------/
    \\                               /
     \\________________USS TURING___/\n".red +
   "   wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
  wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
   wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\n\n".blue
	end

end
