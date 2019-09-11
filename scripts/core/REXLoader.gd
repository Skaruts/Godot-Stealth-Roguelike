extends Resource
class_name REXLoader

# TODO: check if it really needs to be a resource to be flexible in usage.
# TODO: flags 'FORCE_2D' and 'FORCE_3D' to force csv to poop out a 3D array
#       and xp to be merged down to 2D.

enum { BLACK=1, TRANSP=2 }


class REXImage:
	var w:int
	var h:int
	var num_layers:int
	var cells := []


static func _cell(g, f, b) -> Dictionary:
	return {
		glyph = g,
		fg = f,
		bg = b
	}


static func _validate_extension(file_name:String, required_ext:String) -> bool:
	var ext = file_name.get_extension()
	return ext == required_ext


static func load_csv(file_name:String, flags:int=BLACK):
	assert(_validate_extension(file_name, "csv"))

	var fin = File.new()
	if fin.file_exists(file_name):
		fin.open(file_name, File.READ)
		fin.get_csv_line() # discard first line

		var rex_img = REXImage.new()

		var lines = []
		while not fin.eof_reached():
			lines.append(fin.get_csv_line())

		rex_img.w = lines[-1][0].to_int() +1
		rex_img.h = lines[-1][1].to_int() +1
		rex_img.num_layers = 1

		for j in range(rex_img.h):
			rex_img.cells.append([])
			for i in range(rex_img.w):
				var idx = i+j*rex_img.w

				var glyph = int(lines[idx][2])
				var fg = Color(lines[idx][3])
				var bg = Color(lines[idx][4])

				if flags & BLACK:
					if fg == Color.fuchsia: fg = Color.black
					if bg == Color.fuchsia: bg = Color.black

				if flags & TRANSP:
					if fg in [Color.black, Color.fuchsia]: fg.a = 0
					if bg in [Color.black, Color.fuchsia]: bg.a = 0

				rex_img.cells[j].append(_cell(glyph, fg, bg))
		fin.close()
		return rex_img
	return null


static func load_xp(file_name:String, flags:int=BLACK):
	assert(_validate_extension(file_name, "xp"))

	var fin = File.new()
	if fin.file_exists(file_name):
		fin.open(file_name, File.READ)
#		print(fin.open_compressed(file_name, File.READ, File.COMPRESSION_GZIP))
		fin.get_32() # discard xp format version

		var rex_img = REXImage.new()
		rex_img.num_layers = fin.get_32()
		rex_img.w = fin.get_32()
		rex_img.h = fin.get_32()

		# RexPaint uses Column Major order, but I prefer Row Major,
		# so I init cells in Row Major...
		for k in range(rex_img.num_layers):
			rex_img.cells.append([])
			for j in range(rex_img.h):
				rex_img.cells[k].append([])
				for i in range(rex_img.w):
					rex_img.cells[k][j].append(null)

		# ...and invert the loop order to populate them (maybe there's a better way?)
		for k in range(rex_img.num_layers):
			if k > 0:
				fin.get_32() # width and height exist at the start of each
				fin.get_32() # layer, so they must be discarded here

			for i in range(rex_img.w):
				for j in range(rex_img.h):
					var glyph = fin.get_32()
					var fg = Color(fin.get_8()/255.0, fin.get_8()/255.0, fin.get_8()/255.0 )
					var bg = Color(fin.get_8()/255.0, fin.get_8()/255.0, fin.get_8()/255.0 )

					if flags & BLACK:
						if fg == Color.fuchsia: fg = Color.black
						if bg == Color.fuchsia: bg = Color.black

					if flags & TRANSP:
						if fg in [Color.black, Color.fuchsia]: fg.a = 0
						if bg in [Color.black, Color.fuchsia]: bg.a = 0

					rex_img.cells[k][j][i] = _cell(glyph, fg, bg)
		fin.close()
		return rex_img
	return null