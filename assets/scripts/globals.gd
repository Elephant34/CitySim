extends Node


func save_grid(grid):
	# Stores the game data to a persistant file

	var grid_save = File.new()

	grid_save.open("user://CitySim_map.save", File.WRITE)
	
	grid_save.store_line(to_json(grid))

	grid_save.close()
	
	return