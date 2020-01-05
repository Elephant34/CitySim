extends TileMap

var grid
var tile

var width = globals.map_size.x
var height = globals.map_size.y

var name_map = {
	"Grass": 0,
	"Forest": 6,
	"Gold": 7,
	"Beach": 8,
	"Stone": 5,
	"Coal": 1,
	"Iron": 2,
	"Gem": 3,
	"Water": 4,
	"Void": 9
}

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
	new_grid.resize(width)
	
	for column in width:
		new_grid[column] = []
		new_grid[column].resize(height)
		for row in height:
			# Sets the predetermind layout sections
			if column in [0, width-1] or row in [0, height-1]:
				# Gived edges
				tile = name_map["Void"]
			elif column in [0, 1, 2, 3]:
				# Give ocean
				tile = name_map["Water"]
			elif column == 4:
				# Give beach
				tile = name_map["Beach"]
			else:
				# Fills in main tiles with random areas
				tile = globals.rng_generate(0,7)
			
			new_grid[column][row] = tile
	
	return new_grid

func draw_grid():
	for column in width:
		for row in height:
			set_cell(column, row, grid[column][row])