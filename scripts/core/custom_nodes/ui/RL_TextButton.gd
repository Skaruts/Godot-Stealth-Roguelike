extends RL_BaseButton
class_name RL_TextButton

var text := "" setget __set_text__
var length := 0

func _init(x:int, y:int, t:String, style_override=null).(x, y):
	name = "RL_TextButton"

	if style_override:  style = style_override
	else:               style = core.theme.button

	set_colors(style.fg_normal, style.bg_normal)
	self.text = t

func draw():
	if visible:
		terminal.printl(gx, gy, text, fg, bg)


func __set_text__(t:String):
	text = t
	set_size(t.length(), 1)

func length():
	return text.length()
