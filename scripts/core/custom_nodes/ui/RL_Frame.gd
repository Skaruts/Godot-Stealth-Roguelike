extends RL_Control
class_name RL_Frame

var _cellmap := []
var _fgs := []
var _bgs := []

func _init(x:int, y:int, w:int, h:int, style_override=null).(x, y):
	name = "RL_Frame"

	set_min_size(9, 9)
	set_size(w, h)

	if style_override:  style = style_override
	else:               style = core.theme.frame

	connect("resized", self, "_on_resized")
	_build_cellmap()

func draw():
	if visible:
		terminal.batch(x, y, _cellmap, _fgs, style.bg)

func _on_resized():
	_build_cellmap()


func _init_cellmap():
	_cellmap.clear()
	_fgs.clear()
	_bgs.clear()

	for j in range(h):
		_cellmap.append([])
		_fgs.append([])
		_bgs.append([])
		for i in range(w):
			_cellmap[j].append(null)
			_fgs[j].append(null)
			_bgs[j].append(null)

func _set_cell(x, y, glyph, fg, bg):
	_cellmap[y][x] = glyph
	_fgs[y][x] = fg
	_bgs[y][x] = bg

func _build_cellmap():
	_init_cellmap()

	var lines
	if style.thickness == 0: lines = Charcodes.thin_lines
	else:                    lines = Charcodes.thick_lines

	for j in range(h):
		for i in range(w):
			# corners
			if   i == 0 and j == 0:			_set_cell(i, j, lines.TL, style.fg_0, style.bg)
			elif i == 0 and j == h-1:		_set_cell(i, j, lines.BL, style.fg_0, style.bg)
			elif i == w-1 and j == 0:		_set_cell(i, j, lines.TR, style.fg_0, style.bg)
			elif i == w-1 and j == h-1:		_set_cell(i, j, lines.BR, style.fg_0, style.bg)

			# h lines
			elif i in [1, w-2]  and j in [0, h-1]:	_set_cell(i, j, lines.HL, style.fg_1, style.bg)
			elif i in [2, w-3]  and j in [0, h-1]:	_set_cell(i, j, lines.HL, style.fg_2, style.bg)
			elif i in [3, w-4]  and j in [0, h-1]:	_set_cell(i, j, lines.HL, style.fg_3, style.bg)

			# v lines
			elif i in [0, w-1]  and j in [1, h-2]:	_set_cell(i, j, lines.VL, style.fg_1, style.bg)
			elif i in [0, w-1]  and j in [2, h-3]:	_set_cell(i, j, lines.VL, style.fg_2, style.bg)
			elif i in [0, w-1]  and j in [3, h-4]:	_set_cell(i, j, lines.VL, style.fg_3, style.bg)

			else: _set_cell(i, j, 0, null, null)




