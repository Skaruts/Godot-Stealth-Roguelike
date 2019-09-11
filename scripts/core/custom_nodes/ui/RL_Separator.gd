extends RL_Control
class_name RL_Separator

var _fgs := []
var colors := []
var length := 1

func _init(x:int, y:int, l:int, style_override=null).(x, y):
	name = "RL_Separator"
	length = l
	set_min_size(1, 1)

	if style_override:  style = style_override
	else:               style = core.theme.separator

	colors = [ style.fg_0, style.fg_1, style.fg_2, style.fg_3, style.fg_4 ]

	connect("resized", self, "_on_resized")
	_build_cellmap()

func _on_resized():
	_build_cellmap()

func _build_cellmap():
	_fgs.clear()

	for i in range(length):
		if   length <  3: _fgs.append(0)
		elif length <  4: _fgs.append(1)
		elif length <  7: _fgs.append(2)
		elif length < 10: _fgs.append(3)
		else:             _fgs.append(4)

	if length > 2:
		_fgs[0] = 0
		_fgs[length-1] = 0

		if length < 12:
			_fgs[1] = 1
			_fgs[length-2] = 1

			_fgs[2] = 2
			_fgs[length-3] = 2

			_fgs[3] = 3
			_fgs[length-4] = 3
		else:
			_fgs[1] = 0
			_fgs[length-2] = 0

			_fgs[2] = 1
			_fgs[length-3] = 1

			_fgs[3] = 2
			_fgs[length-4] = 2

			_fgs[4] = 3
			_fgs[length-5] = 3


#	if w % 2 == 0:
#		_set_cell(int(w/2)+1, Charcodes.HL, Colors.GREY4)




