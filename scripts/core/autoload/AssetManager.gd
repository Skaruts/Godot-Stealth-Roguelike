extends Node
# autoLoaded script

var _fonts_path = "res://data/fonts/"

var _fonts = []  # stores preloaded textures
var _default_font = 6
var _curr_font = _default_font


func _init():
	_load_fonts()

func _load_fonts():
	# check if fonts path exists

	_fonts.append( load("res://data/fonts/cp437_8x8.png") )
	_fonts.append( load("res://data/fonts/cp437_10x10.png") )
	_fonts.append( load("res://data/fonts/cp437_12x12.png") )
	_fonts.append( load("res://data/fonts/cp437_14x14.png") )
	_fonts.append( load("res://data/fonts/cp437_16x16.png") )
	_fonts.append( load("res://data/fonts/cp437_18x18.png") )
	_fonts.append( load("res://data/fonts/cp437_20x20.png") )



####################################################
# Interface
#---------------------------------------------------
func switch_font(dir):   # -1 up | 1 down
	_curr_font = Utils.wrap(_curr_font+dir, 0, _fonts.size()-1)




# tileset must have 16x16 tiles
func get_font_size():  return Vector2(get_font_width(), get_font_height())
func get_font_width():  return _fonts[_curr_font].get_width()/16
func get_font_height(): return _fonts[_curr_font].get_height()/16

func get_font():	return _fonts[_curr_font]

