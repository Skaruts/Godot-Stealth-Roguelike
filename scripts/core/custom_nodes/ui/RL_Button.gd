extends RL_BaseButton
class_name RL_Button

var text = null setget __set_text__
var icon = null setget __set_icon__

func _init(x:int, y:int, t:="", i:=0, style_override=null).(x, y):
	name = "RL_Button"

	if style_override:  style = style_override
	else:               style = core.theme.button

	set_colors(style.fg_normal, style.bg_normal, true)

	if not t and not i: i = 254
	self.text = t
	self.icon = i

#	draw()

func draw():
	if visible:
		if icon and text:
			terminal.put(gx, gy, icon, fg, bg)
			terminal.printl(gx+1, gy, text, fg, bg)
		elif icon:
			terminal.put(gx, gy, icon, fg, bg)
		elif text:
			terminal.printl(gx, gy, text, fg, bg)


func __set_text__(t:="", emit:=true):
	if t.length():
		if icon: t = " " + t
		text = t
		_check_size()
	else:
		text = null


func __set_icon__(i:=0, emit:=true):
	if i > 0:
		icon = i
		if text: text = " " + text
		_check_size()
	else:
		icon = null


func length():
	return text.length()

func _check_size():
	if icon and text:  set_size(2 + text.length(), 1)
	elif icon:         set_size(1, 1)
	elif text:         set_size(text.length(), 1)

