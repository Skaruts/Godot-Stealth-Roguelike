extends Resource
class_name Data


const GW = 80
const GH = 50
const DEF_FG = Color.white
const DEF_BG = Color.black
#const LOG_FILE = "res://data/logs.dat"
################################################################################

#    Game Settings

################################################################################
const def_settings := {
	gen_seed              = "bhdfiogbdfjg",
	use_FOW               = true,
	show_walls_diagonally = true,
	show_all_map          = false,
	max_light_level       = 5,
	tile_darken_factor    = 0.4,   # multiplier for darkening tile colors
	key_repeat            = true,      # if false, you move once per key press
	key_cooldown          = 0.10,#25
	key_1st_cooldown      = 0.250,
	ui_minimal            = false,
	ui_flip_h             = 0,
	ui_flip_v             = 1,
	viewport_def_size     = Vector2(51, 46) # Vector2(52, GRID_HEIGHT-2)
}

################################################################################

#    Colors

################################################################################
const def_theme := {
	def_fg = Color('808080'),
	def_bg = Color.black,
	def_disabled = Colors.GREY1,
	thickness = 0,

	label = {
		fg = Color('808080'),
		bg = Color.black,
	},

	button = {
		fg_normal = Colors.YELLOW2,
		fg_hovered = Colors.YELLOW2,
		fg_pressed = Colors.YELLOW4,
		fg_disabled = Colors.GREY1,

		bg_normal = Color.black,
		bg_hovered = Colors.GREY0,
		bg_pressed = Colors.GREY0,
		bg_disabled = Color.black,
	},

	check_button = {
		fg_normal = Colors.YELLOW2,
		fg_hovered = Colors.YELLOW2,
		fg_pressed = Colors.YELLOW2,
		fg_disabled = Colors.GREY1,

		bg_normal = Color.black,
		bg_hovered = Colors.GREY0,
		bg_pressed = Colors.GREY0,
		bg_disabled = Color.black,
	},

	frame = {
		fg_0 = Color("808080"),
		fg_1 = Color("4d4d4d"),
		fg_2 = Color("333333"),
		fg_3 = Color("1a1a1a"),

		bg = Color.black,
		thickness = 0,
	},

	separator = {
		fg_0 = Colors.GREY0,
		fg_1 = Colors.GREY1,
		fg_2 = Colors.GREY2,
		fg_3 = Colors.GREY3,
		fg_4 = Colors.GREY4,

		bg = Color.black,
		thickness = 0,
	},
}



################################################################################

#    Internals

################################################################################
var mouse_pos := Vector2()
