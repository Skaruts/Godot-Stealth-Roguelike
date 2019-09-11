extends Node
class_name Utils

################################################################################
# Returns a random number between 'from' and 'to'
# Accepts floats or ints
#
# if 'to' is ignored, 'from' is assumed to be the
# maximum value, from a minimum of 0
#
#   rand(100)   # returns random between 0 and 100
#   rand(20, 80) # returns random between 20 and 80
#-------------------------------------------------------------------------------
static func rand(from, to=null):
	if to == null:
		to = from
		if to is float:
			return rand_range(0, to)
		return randi() % to

	if from is float or to is float:
		return rand_range(from, to)

	return randi() % (to - from) + from




static func wrap(num, low, hi):
#	if num < low: return hi
#	if num > hi: return low
#	return num
	return hi if num < low else low if num > hi else num






static func mandist(p1, p2):
	return abs(p1.x - p2.x) + abs(p1.y - p2.y)

##############################################################
# Calculates a line in a grid, using Bresenham's or
# RedBlobGames's line algorithms.
#-------------------------------------------------------------
# Returns an array of Vector2 points.
#-------------------------------------------------------------
static func line(p0, p1, bres=true):
	if bres:  return bresenham(p0, p1)
	else:     return red_blob_line(p0, p1)

# Red Blob Game's line algorithm
# Adapted from:
# https://www.redblobgames.com/grids/line-drawing.html
static func red_blob_line(p0, p1):
	var points = []
	var N = diagonal_distance(p0, p1)
	for step in range(N): # (var step = 0; step <= N; step++):
		var t
		if N == 0:  t = 0.0
		else:       t = step / N
		points.append( round_point( lerp_point(p0, p1, t) ) )
	return points

static func lerp_point(p0, p1, t):
	return Vector2( lerp(p0.x, p1.x, t), lerp(p0.y, p1.y, t) )

static func diagonal_distance(p0, p1):
	var dx = p1.x - p0.x
	var dy = p1.y - p0.y
	return max( abs(dx), abs(dy) )

static func round_point(p):
	return Vector2( round(p.x), round(p.y) )


# Bresenham's line algorithm
# Adapted from Luke M.'s python implementation:
# https://gist.github.com/flags/1132363
static func bresenham(p0, p1):
	var points = []

	var steep = abs(p1.y-p0.y) > abs(p1.x-p0.x)
	if steep:
		p0 = vswap(p0)
		p1 = vswap(p1)

	if p0.x > p1.x:
		# 'flippin and floppin'
		var _x0 = int(p0.x)
		var _x1 = int(p1.x)
		p0.x = _x1
		p1.x = _x0

		var _y0 = int(p0.y)
		var _y1 = int(p1.y)
		p0.y = _y1
		p1.y = _y0

	var dx = p1.x - p0.x
	var dy = abs(p1.y - p0.y)
	var error = 0
	var derr = dy/float(dx)

	var ystep = 0
	var y = p0.y

	if p0.y < p1.y: ystep = 1
	else:           ystep = -1

	for x in range( p0.x, p1.x+1):
		if steep:
			points.append( Vector2(y,x) )
		else:
			points.append( Vector2(x,y) )

		error += derr
		if error >= 0.5:
			y += ystep
			error -= 1.0
	return points

# Swap the x and y values of a Vector2
static func vswap(vec2):
	return Vector2(vec2.y, vec2.x)


##############################################################
# Rounds a number 'num' to the nearest multiple of 'mult'.
# (Useful for grid operations.)
#-------------------------------------------------------------
# Returns an int.
#
# mult()  - Rounds to the nearest multiple (up or down)
# cmult() - Ceils to the nearest multiple
# fmult() - Floors to the nearest multiple
#-------------------------------------------------------------
static func mult(num, mult):
	if mult == 0: return num
	var remainder = num % mult
	if remainder == 0: return num

	var diff1 = num - fmult(num, mult)
	var diff2 = cmult(num, mult) - num

	if diff1 < diff2:   return num + mult - remainder
	else:               return num + mult + remainder

static func cmult(num, mult):
	if mult == 0: return num
	var remainder = num % mult
	if remainder == 0: return num   # remainder of 0 = num is multiple of mult, so return it (not needed in fmult)
	return num + mult - remainder

static func fmult(num, mult):
	if mult == 0: return num
	var remainder = num % mult
	return num - remainder

# nmult() should round to next multiple of mult with the option to
# specify dir (ceil or floor) and of excluding mult
# (to never allow rounding to itself if exc=true)
static func nmult(num, mult, dir = null, exc = true):
	# problem:
	#   ceil always excludes num by default
	#   floor always includes num by default
	#
	# I don't yet know how to turn either of them around
	#
	# return num + mult - remainder     # this only works for ceil excluding num
	# return num - mult + remainder     # this only works for floor including num
	pass




##############################################################
# Lists files in a directory
#-------------------------------------------------------------
# Returns an Array of strings (file names).
#
# If a file extension is specified in 'ext' (ex: "png" or
# ".png"), it lists only the files ending with that extension.
#-------------------------------------------------------------
static func list_files(path, ext=""):
	var files = []
	var dir = Directory.new()

	if ext != "" and ext[0] != ".":
		ext = "." + ext

	dir.open( path )
	dir.list_dir_begin()

	var file = dir.get_next()
	while file != "":
		if not dir.current_is_dir():
			if ext != "" and file.ends_with( ext ):
				files.append( file )
			else:
				files.append( file )
		file = dir.get_next()

	dir.list_dir_end()
	return files





##############################################################
# Loads TAB separated data from a data file.
#-------------------------------------------------------------
# Returns an array containing each line from the file, with
# its elements separated into an array. Parsing of the data
# should take place elsewhere.
#
# Format for the file content should be:
# element1 ___ ___ element2 ___ ___ elementN
# # Comment line using '#'
#
# Elements should be separated by 1 or more TAB. Spaces are
# irrelevant, and if they exist they're automatically removed.
#
# Doesn't yet exclude comments placed after valid data.
#-------------------------------------------------------------
static func get_data_file(filename):
	var lines = []
	var fin = File.new()

	if fin.file_exists(filename):
		fin.open(filename, fin.READ)

		while not fin.eof_reached():
			var line = fin.get_line()
			if line.length() and not line[0] in ['#', '\n']:
				var l = line.replace(' ', '').split('\t', false)
				var is_valid = true
				for p in l:
					if not p.is_valid_identifier() and p != '-':
						is_valid = false
						break

				if is_valid:
					lines.append( l )

		fin.close()
		return lines

	return null

static func get_file_lines(filename):
	var lines = []
	var fin = File.new()

	if fin.file_exists(filename):
		fin.open(filename, fin.READ)

		while not fin.eof_reached():
			var line = fin.get_line()
			if line.length():
				lines.append( line )

		fin.close()
		return lines
	return null

static func save_file_lines(lines, filename):
	var fout = File.new()
	fout.open(filename, File.WRITE)

	for l in lines:
		fout.store_line(l)

	fout.close()






