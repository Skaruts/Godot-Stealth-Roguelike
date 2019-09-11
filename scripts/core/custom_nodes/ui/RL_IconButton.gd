extends RL_BaseButton
class_name RL_IconButton

var icon := 0

func _init(x:int, y:int, i:int, style_override=null).(x, y):
	name = "RL_IconButton"

	if style_override:  style = style_override
	else:               style = core.theme.button
	set_colors(style.fg_normal, style.bg_normal)

	icon = i
	set_size(1, 1)


func draw():
	if visible:
		terminal.put(gx, gy, icon, fg, bg)





