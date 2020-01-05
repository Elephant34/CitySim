extends TileMap

var grid

func _ready():
	grid = load_grid()
	
	if not grid:
		grid = generate_grid()
		
	globals.save_grid(grid)
	
	draw_grid()
	
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
	
	var new_grid = []
	new_grid.resize(100)
	
	for column in 100:
		new_grid[column] = []
		new_grid[column].resize(100)
		for row in 100:
			var tile = globals.rng_generate(0,9)
			
			new_grid[column][row] = tile
	
	return new_grid

func draw_grid():
	for column in 100:
		for row in 100:
			set_cell(column, row, grid[column][row])