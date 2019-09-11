extends RL_BaseButton
class_name RL_CheckButton

var _icon:int = Charcodes.CHECK_BTN_UNCHECKED
var _checked := false

func _init(x:int, y:int, style_override=null).(x, y):
	name = "RL_CheckButton"

	is_toggle = true

	if style_override:  style = style_override
	else:               style = core.theme.check_button
	set_colors(style.fg_hovered, style.bg_normal)

	connect("toggled", self, "_on_toggle")
	set_size(1, 1)


func draw():
	if visible:
		terminal.put(x, y, _icon, fg, bg)



func _on_toggle():
	_checked = not _checked
	if _checked:  _icon = Charcodes.CHECK_BTN_CHECKED
	else:         _icon = Charcodes.CHECK_BTN_UNCHECKED


func __is_toggle__(enable:bool):
	print("(RL_CheckButton) Error - RL_CheckButton can't be set to non-toggle.")
	assert(false)


#func _on_pressed():
#	_is_down = true
#	set_colors(Data.def_theme.btn_cb_fg_pressed, Data.def_theme.btn_bg_pressed)
#	emit_signal("toggled")
#	emit_signal("redraw_event")
#
#func _on_released():
#	_is_down = false
#	set_colors(Data.def_theme.btn_cb_fg_hovered, Data.def_theme.btn_bg_hovered)
#	emit_signal("toggled")
#	emit_signal("redraw_event")
