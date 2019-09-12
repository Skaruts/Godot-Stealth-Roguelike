extends RL_BoxContainer
class_name RL_HBoxContainer



func _init(x:int, y:int, w:int, h:int).(x, y, w, h):
	name = "RL_HBoxContainer"
	connect("sort_children", self, "_on_sort_children")
	vertical = false





