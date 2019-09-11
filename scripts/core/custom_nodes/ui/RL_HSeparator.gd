extends RL_Separator
class_name RL_HSeparator


func _init(x:int, y:int, l:int, style_override=null).(x, y, l, style_override):
	name = "RL_HSeparator"
	set_size(l, 1)

func draw():
	if visible:
		for i in range(length):
			terminal.put(x+i, y, Charcodes.HL, colors[ _fgs[i] ], style.bg)

