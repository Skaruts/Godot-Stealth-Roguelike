extends SK_Separator
class_name SK_VSeparator


func _init(x:int, y:int, l:int, style_override=null).(x, y, l, style_override):
	name = "SK_VSeparator"
	set_size(1, l)

func draw():
	if visible:
		for j in range(length):
			terminal.put(x, y+j, Charcodes.VL, colors[ _fgs[j] ], style.bg)

