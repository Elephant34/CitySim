extends Node

var rng = RandomNumberGenerator.new()

var map_size = Vector2(110, 110)

func _ready():
    rng.randomize()
	
func rng_generate(_min, _max):
	return rng.randi_range(_min, _max)

func save_grid(grid):
	# Stores the game map to a persistant file

	var grid_save = File.new()

	grid_save.open("user://CitySim_map.save", File.WRITE)
	
	grid_save.store_line(to_json(grid))

	grid_save.close()
	
	return