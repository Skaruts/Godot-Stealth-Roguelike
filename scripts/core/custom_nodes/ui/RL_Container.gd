extends RL_Control
class_name RL_Container

signal sort_children

var _controls := []

func _init(x:int, y:int, w:int, h:int).(x, y):
	name = "RL_Container"
	set_size(w, h)

func draw():
	if visible:
		for c in _controls:
			if c.visible:
				c.draw()

func input(event:InputEvent):
	if visible and active:
		for c in _controls:
			if c.visible and c.active:
				c.input(event)

func add_child(c, legible_unique_name:=false):
	if not _controls.has(c):
		.add_child(c)
		_controls.append(c)
		c.parent_is_container = true


func remove_child(c):
	if _controls.has(c):
		.remove_child(c)
		_controls.erase(c)
		c.parent_is_container = false


#func set_visible(enable:bool, emit:=true):
#	.set_visible(enable, false)
#	for c in _controls:
#		c.set_visible(enable, false)

#	emit_signal("visibility_changed")


func set_active(enable:bool):
	.set_active(enable)
	for c in _controls:
		c.active = enable


func _sort_children():
	pass
