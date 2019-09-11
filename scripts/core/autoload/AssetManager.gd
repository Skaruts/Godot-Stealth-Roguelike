extends Node
# autoLoaded script

var _default_image = 4
var _fonts_file = "res://assets/fonts.dat"
var _fonts_path = "res://assets/fonts/"

var _fonts = {}  # stores preloaded textures
var _fnames = [] # stores the name of each font set

var _current_image_idx = _default_image
var _current_image_name
var _curr_font
var _curr_texture

var use_ascii = true		# not useful yet (but being used already)

func _init():
	_load_fonts()
	_set_font( _current_image_idx )

func _load_fonts():

	# check if fonts path exists

	var file = Utils.get_data_file( _fonts_file )
	if file != null:
		for l in file:
			var fname = l[0]
			var ftxt = load( _fonts_path + l[1] + '.png' )
			var fasc = load( _fonts_path + l[2] + '.png' )
			# var fgfx = load( _fonts_path + l[3] + '.png' )

			_fnames.append( fname )
			_fonts[fname] = [ ftxt, fasc ] #, fgfx ]
	else:
		print("ERROR: couldn't find file: %s." % [_fonts_file])
		core.exit()

func _set_font(cf):
	_current_image_name = _fnames[_current_image_idx]
	_curr_font = _fonts[_current_image_name][0]
	if use_ascii: _curr_texture = _fonts[_current_image_name][1]
	# else:         _curr_texture = _fonts[_current_image_name][2]




####################################################
# Interface
#---------------------------------------------------
func switch_font(dir):   # -1 up | 1 down
	var old_index = _current_image_idx
	_current_image_idx += dir

	if _current_image_idx >= _fnames.size():
		_current_image_idx = 0

	if _current_image_idx < 0:
		_current_image_idx = _fnames.size()-1

	if _current_image_idx != old_index:
		_set_font( _current_image_idx )
		return true

	return false

# tileset must have 16x16 tiles
func get_tile_sizes():  return Vector2(get_tile_width(), get_tile_height())
func get_tile_width():  return _curr_texture.get_width()/16
func get_tile_height(): return _curr_texture.get_height()/16

func get_font_sizes():  return Vector2(get_font_width(), get_font_height())
func get_font_width():  return _curr_font.get_width()/16
func get_font_height(): return _curr_font.get_height()/16

func get_texture():	return _curr_texture
func get_font():	return _curr_font

