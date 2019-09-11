extends SK_Range
class_name SK_ProgressBar

signal emptied
signal filled

enum Directions { UP, DOWN, LEFT, RIGHT, MAX_DIRECTIONS }


var glyph:int = Charcodes.PROGRESS_BAR
var facing:int = Directions.LEFT setget __set_facing__


func _init(x:int, y:int, w:int, h:int, val:int, max_val:int, dir='right', style_override=null).(x, y, val, max_val):
	name = "SK_ProgressBar"

	self.facing = dir

	if style_override:  style = style_override
	else:               style = core.theme.progress_bar

	set_colors(fg, bg)
	set_size(w, h)


func draw():
	if visible:
		match facing:
			Directions.UP:
				var fill:int = int( float(value) / max_value * h )
				var remainder:float = float(value) / max_value * h - fill
				var length:int = h-1-fill

				for j in range(h):
					for i in range(w):
						if j > length:     terminal.put(x+i, y+j, glyph, style.fg, style.bg)
						elif j == length:  terminal.put(x+i, y+j, glyph, style.fg * remainder, style.bg)

			Directions.LEFT:
				var fill:int = int( float(value) / max_value * w )
				var remainder:float = float(value) / max_value * w - fill
				var length:int = w-1-fill
				for j in range(h):
					for i in range(w):
						if i > length:     terminal.put(x+i, y+j, glyph, style.fg, style.bg)
						elif i == length:  terminal.put(x+i, y+j, glyph, style.fg * remainder, style.bg)

			Directions.DOWN:
				var fill:int = int( float(value) / max_value * h )
				var remainder:float = float(value) / max_value * h - fill
				var length:int = fill
				for j in range(h):
					for i in range(w):
						if j < length:     terminal.put(x+i, y+j, glyph, style.fg, style.bg)
						elif j == length:  terminal.put(x+i, y+j, glyph, style.fg * remainder, style.bg)
#						else:              break

			Directions.RIGHT:
				var fill:int = int( float(value) / max_value * w )
				var remainder:float = float(value) / max_value * w - fill
				var length:int = fill
				for j in range(h):
					for i in range(w):
						if i < length:     terminal.put(x+i, y+j, glyph, style.fg, style.bg)
						elif i == length:  terminal.put(x+i, y+j, glyph, style.fg * remainder, style.bg)
						else:              break


func __set_facing__(dir):
	if typeof(dir) == TYPE_STRING:
		match dir:
			"r", "right": facing = Directions.RIGHT
			"l", "left":  facing = Directions.LEFT
			"u", "up":    facing = Directions.UP
			"d", "down":  facing = Directions.DOWN
	elif typeof(dir) == TYPE_INT:
		facing = clamp(dir, 0, Directions.MAX_DIRECTIONS)



