extends SK_Widget
class_name SK_BaseButton

var tool_tip := ""

signal pressed
signal released
signal toggled


var _is_down := false
var _is_hovered := false
var is_toggle := false setget __is_toggle__



func _init(x:int, y:int).(x, y):
	name = "SK_BaseButton"


func _input(event:InputEvent):
	if visible and active:
		if event is InputEventMouseButton or event is InputEventMouseMotion:
			var mouse_over:bool = check_mouse()
			if mouse_over:
				if not _is_hovered:
					_on_mouse_enter()

				if event is InputEventMouseButton and event.button_index == 1:
					if not is_toggle:
						if event.pressed and not _is_down:    _on_pressed()
						elif not event.pressed and _is_down:  _on_released()
						else:                                 _is_down = false
					else:
						if event.pressed:
							if _is_down:    _on_released()
							else:           _on_pressed()
			else:
				if _is_hovered:
					_on_mouse_exit()


func _on_mouse_enter():
	_is_hovered = true
	if not is_toggle:  set_colors(style.fg_hovered, style.bg_hovered)
	else:              set_colors(fg, style.bg_hovered)
	emit_signal("mouse_enter")



func _on_mouse_exit():
	_is_hovered = false
	if not is_toggle:
		_is_down = false
		set_colors(style.fg_normal, style.bg_normal)
	else:
		set_colors(fg, style.bg_normal)
	emit_signal("mouse_exit")


func _on_pressed():

	_is_down = true
	set_colors(style.fg_pressed, style.bg_pressed)
	if is_toggle:  emit_signal("toggled")
	else:          emit_signal("pressed")


func _on_released():
	print("Button input")
	_is_down = false
	set_colors(style.fg_hovered, style.bg_hovered)
	if is_toggle:  emit_signal("toggled")
	else:          emit_signal("released")


# to override by buttons on which the toggle state can't be changed
func __is_toggle__(enable:bool):
	is_toggle = enable