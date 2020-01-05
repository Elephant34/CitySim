extends TileMap

var grid

func _ready():
	grid = load_grid()
	
	if not grid:
		grid = generate_grid()
		
	globals.save_grid(grid)
	
func load_grid():
	# Opens the game data file to load the values

	var grid_save = File.new()
	
	# If the data is blank
	if not grid_save.file_exists("user://CitySim_map.save"):
		return []
	
	grid_save.open("user://CitySim_map.save", File.READ)

	var data = parse_json(grid_save.get_as_text())

	grid_save.close()

	return data

func generate_grid():
	# Gemerates a new random map
	
	return [[1,4,2,8],[4,3,67,3],[35,3,2,4]]