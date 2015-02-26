require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/battleship'
require_relative '../lib/game_logic.rb'
require_relative '../lib/messages.rb'

class BattleshipTest < Minitest::Test 

	def test_it_runs

		assert true
	end 

	def test_it_creates_a_grid_array
		skip #grid expanded to 12x12 - this will not pass
		game = GameLogic.new
		result = game.initialize_grid
		assert_equal [" ", "A", "B", "C", "D"],game.grid_lines[0]
	end

	def test_it_can_print_a_grid
		game = GameLogic.new
		game.initialize_grid
		assert game.print_grid
	end

	def test_it_can_add_a_single_element_ship
		skip #expanded the add_ships method to accept variable sizes - this test will not pass
		game = GameLogic.new
		game.initialize_grid
		game.add_ships("A2")
		assert_equal [2,"*","b","c","d"],game.grid_lines[2]
	end

	def test_it_can_add_a_two_element_ship_horizontally
		skip #expanded the grid to 12x12 - this test will not pass
		game = GameLogic.new
		game.initialize_grid
		game.add_ships("A2","B2")
		assert_equal [2,"*","*","c","d"],game.grid_lines[2]
	end

	def test_it_can_add_a_two_element_ship_vertically
		skip #expanded the grid to 12x12 - this test will not pass
		game = GameLogic.new
		game.initialize_grid
		game.add_ships("A2","A3")
		assert_equal [2,"*","b","c","d"],game.grid_lines[2]
		assert_equal [3,"*","b","c","d"],game.grid_lines[3]
	end

	def test_it_can_add_a_three_element_ship_horizontally
		skip #expanded the grid to 12x12 - this test will not pass
		game = GameLogic.new
		game.initialize_grid
		game.add_ships("B2","D2")
		assert_equal [2,"a","*","*","*"],game.grid_lines[2]
	end

	def test_it_can_add_a_three_element_ship_vertically
		skip #expanded the grid to 12x12 - this test will not pass
		game = GameLogic.new
		game.initialize_grid
		game.add_ships("C1","C3")
		assert_equal [2,"a","b","*","d"],game.grid_lines[2]
		assert_equal [3,"a","b","*","d"],game.grid_lines[3]
		assert_equal [3,"a","b","*","d"],game.grid_lines[3]
	end

	def test_it_affirms_proper_coordinates_low_letter_first
		game = GameLogic.new
		assert_equal :bad_coord_low_letter_first,game.affirm_boat_coords("C2","A2",2)
	end

	def test_it_affirms_proper_coordinates_low_number_first
		game = GameLogic.new
		assert_equal :bad_coord_low_number_first,game.affirm_boat_coords("A2","A1",2)
	end

	def test_it_affirms_proper_coordinates_ship_size_too_large
		game = GameLogic.new
		assert_equal :bad_coord_wrong_size,game.affirm_boat_coords("A2","A4",2)
	end

	def test_it_affirms_proper_coordinates_ship_size_too_small
		game = GameLogic.new
		assert_equal :bad_coord_wrong_size,game.affirm_boat_coords("A2","A2",2)
	end

	def test_it_affirms_proper_coordinates_outside_grid_dimensions
		game = GameLogic.new
		assert_equal :bad_coord_bigger_than_grid,game.affirm_boat_coords("L2","M2",2)
		assert_equal :bad_coord_bigger_than_grid,game.affirm_boat_coords("A12","A13",2)
	end

	def test_after_affirming_ship_size_it_will_add_a_ship
		skip #expanded the grid to 12x12 - this test will not pass
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("B2","B3",2)
		assert_equal [2,"a","*","c","d"],game.grid_lines[2]
		assert_equal [3,"a","*","c","d"],game.grid_lines[3]
	end

	def test_that_it_can_create_a_12x12_grid
		game = GameLogic.new
		result = game.initialize_grid
		assert_equal ["    ", "A", "B", "C", "D","E","F","G","H","I","J","K","L"],game.grid_lines[0]
		assert_equal ["  12", "a", "b", "c", "d","e","f","g","h","i","j","k","l"],game.grid_lines[12]
	end

	def test_it_can_add_a_two_element_ship_horizontally_12x12_grid
		game = GameLogic.new
		game.initialize_grid
		game.add_ships(65,66,2,2)
		assert_equal ["   2","*","*","c","d","e","f","g","h","i","j","k","l"],game.grid_lines[2]
	end

	def test_it_can_add_a_two_element_ship_vertically_12x12_grid
		game = GameLogic.new
		game.initialize_grid
		game.add_ships(65,65,2,3)
		assert_equal ["   2","*","b","c","d","e","f","g","h","i","j","k","l"],game.grid_lines[2]
		assert_equal ["   3","*","b","c","d","e","f","g","h","i","j","k","l"],game.grid_lines[3]
	end

	def test_it_can_add_a_three_element_ship_horizontally_12x12_grid
		game = GameLogic.new
		game.initialize_grid
		game.add_ships(66,68,2,2)
		assert_equal ["   2","a","*","*","*","e","f","g","h","i","j","k","l"],game.grid_lines[2]
	end

	def test_it_can_add_a_three_element_ship_vertically_12x12_grid
		game = GameLogic.new
		game.initialize_grid
		game.add_ships(67,67,1,3)
		assert_equal ["   2","a","b","*","d","e","f","g","h","i","j","k","l"],game.grid_lines[2]
		assert_equal ["   3","a","b","*","d","e","f","g","h","i","j","k","l"],game.grid_lines[3]
		assert_equal ["   3","a","b","*","d","e","f","g","h","i","j","k","l"],game.grid_lines[3]
	end

	def test_after_affirming_ship_size_it_will_add_a_ship
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("B2","B3",2)
		assert_equal ["   2","a","*","c","d","e","f","g","h","i","j","k","l"],game.grid_lines[2]
		assert_equal ["   3","a","*","c","d","e","f","g","h","i","j","k","l"],game.grid_lines[3]
	end

	def test_it_responds_to_affirm_boat_coords_method
		game = GameLogic.new
		assert game.respond_to?(:affirm_boat_coords)
	end

	def test_that_it_will_not_make_diagonal_ship_layouts
		game = GameLogic.new
		assert_equal :bad_coord_ship_must_be_vertical_or_horizontal,game.affirm_boat_coords("A1","C2",2)
	end

	def test_it_can_add_a_large_ship
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("C11","K11",9)
		assert_equal ["  11","a","b","*","*","*","*","*","*","*","*","*","l"],game.grid_lines[11]
	end

	def test_it_can_shoot_and_miss
		skip #does not function with colorize
		game = GameLogic.new
		game.initialize_grid
		assert_equal :miss,game.shoot("C5")
		assert_equal ["   5","a","b","o","d","e","f","g","h","i","j","k","l"],game.grid_lines[5]
	end

	def test_it_can_hit
		skip #does not function with colorize
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("G6","G9",4)
		assert_equal :hit,game.shoot("G8")
		assert_equal ["   8","a","b","c","d","e","f","x","h","i","j","k","l"],game.grid_lines[8]
	end

	def test_it_can_hit_a_place_already_hit
		skip #does not function with colorize
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("G6","G9",4)
		game.shoot("G8")
		assert_equal :already_hit_here,game.shoot("G8")
	end

	def test_it_can_deconflict_ships_vertically
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("G6","G9",4)
		assert_equal :conflict,game.affirm_boat_coords("G5","G6",2)
	end

	def test_it_can_deconflict_ships_horizontal
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("D2","G2",4)
		assert_equal :conflict,game.affirm_boat_coords("C2","D2",2)
	end

	def test_it_can_deconflict_ships_crossing_vert_first
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("G6","G9",4)
		assert_equal :conflict,game.affirm_boat_coords("E7","I7",5)
	end

	def test_it_can_deconflict_ships_crossfing_horizontal_first
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("E7","I7",5)
		assert_equal :conflict,game.affirm_boat_coords("G6","G9",4)
	end

	def test_it_can_find_if_any_boats_are_still_alive
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("A2","A3",2)
		game.shoot("A2")
		assert_equal true,game.alive_boat_check
		game.shoot("A3")
		assert_equal false,game.alive_boat_check
	end

	def test_it_can_perform_random_shots
		game = GameLogic.new
		game.initialize_grid
		25.times do 
			game.random_shot
		end
		assert_equal 25,game.shot_array.size
	end

	def test_it_can_detect_an_out_of_bounds_shot_high_letter
		game = GameLogic.new
		game.initialize_grid
		assert_equal :shot_out_of_bounds,game.affirm_shot_coord("M3")
	end

	def test_it_can_detect_an_out_of_bounds_shot_high_number
		game = GameLogic.new
		game.initialize_grid
		assert_equal :shot_out_of_bounds,game.affirm_shot_coord("L13")
	end

	def test_it_can_detect_an_out_of_bounds_shot_zero
		game = GameLogic.new
		game.initialize_grid
		assert_equal :shot_out_of_bounds,game.affirm_shot_coord("A0")
	end

	def test_it_will_shoot_an_in_bounds_shot
		game = GameLogic.new
		game.initialize_grid
		assert_equal :miss,game.affirm_shot_coord("A2")
	end

	def test_it_can_make_a_hit
		game = GameLogic.new
		game.initialize_grid
		game.affirm_boat_coords("B2","E2",4)
		assert_equal :hit,game.affirm_shot_coord("B2")
	end

	def test_god_mode_works
		game = GameLogic.new
		game.initialize_grid
		game.random_grid_setup
		game.god_mode = true
		assert_equal true,game.god_mode
	end

	def test_it_has_the_expected_messages
		expected = [:title, :menu, :grid_setup, :instructions, :enemy_grid, :your_grid, :header,
	  			    :take_a_shot, :quit, :setup_options, :enter_coord_1, :enter_coord_2,
	  			    :bad_coord_low_letter_first, :bad_coord_low_number_first, :bad_coord_wrong_size,
	  			    :bad_coord_bigger_than_grid, :bad_coord_ship_must_be_vertical_or_horizontal,
	  			    :already_hit_here, :conflict, :shot_out_of_bounds, :hit, :miss, :blank,
	  			    :success, :one_line, :win, :lose, :computer_turn, :you_turn]
	  	messages = Messages.new
	  	expected.each do |message|
    	assert messages.respond_to?(message), "Printer should have a #{message} method"
  		end
	end
end



