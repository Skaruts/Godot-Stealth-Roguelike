extends RL_Control
class_name RL_Label


var text := "" setget __set_text__
var length := 0

func _init(x:int, y:int, t:String, style_override=null).(x, y):
	name = "RL_Label"

	if style_override:  style = style_override
	else:               style = core.theme.label

	self.text = t
	set_colors(fg, bg)


func draw():
	if visible:
		terminal.printl(x, y, text, style.fg, style.bg)


func __set_text__(t:String):
	text = t
	length = t.length()
	set_size(length, 1)
