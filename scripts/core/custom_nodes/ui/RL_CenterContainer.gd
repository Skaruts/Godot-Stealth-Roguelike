extends RL_Container
class_name RL_CenterContainer


func _init(x:int, y:int, w:int, h:int).(x, y, w, h):
	name = "RL_CenterContainer"


func add_child(c, legible_unique_name:=false):
	.add_child(c)
	c.connect("repositioned", self, "_reposition_widget", [c])
	c.connect("resized", self, "_reposition_widget", [c])
	_reposition_widget(c)


func _reposition_widget(c):
#	print("REPOSITIONING WIDGETS")
	var x = int(w/2) - (c.w/2)
	var y = int(h/2) - (c.h/2)
	c.set_pos(x, y, false)
#	emit_signal("repositioned")