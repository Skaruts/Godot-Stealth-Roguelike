extends RL_Control
class_name RL_Range

signal changed
signal value_changed

var max_value:int = 100   setget __set_max_val__
var value:int = 100       setget __set_val__

func _init(x:int, y:int, val:int, max_val:int).(x, y):
	name = "RL_Range"
	max_value = max_val
	value = clamp(val, 0, max_value)


func __set_max_val__(v:int):
	max_value = v
	if value > max_value:
		value = max_value
		emit_signal("changed")
		emit_signal("redraw_event")


func __set_val__(v:int):
	var old_value := value
	value = clamp(v, 0, max_value)

	emit_signal("value_changed")
	emit_signal("changed")
	emit_signal("redraw_event")

	if value <= 0 and old_value != 0:	                 emit_signal("emptied")
	elif value >= max_value and old_value != max_value:  emit_signal("filled")