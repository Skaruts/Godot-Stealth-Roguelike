extends RL_BoxContainer
class_name RL_VBoxContainer



func _init(x:int, y:int, w:int, h:int).(x, y, w, h):
	name = "RL_VBoxContainer"
	connect("sort_children", self, "_on_sort_children")
	vertical = true