extends RL_Container
class_name RL_CenterContainer


func _init(x:int, y:int, w:int, h:int).(x, y, w, h):
	name = "RL_CenterContainer"


func add(w):
	if not _widgets.has(w):
		_widgets.append(w)
		w.parent = self
		w.connect("repositioned", self, "_reposition_widget", [w])
		w.connect("resized", self, "_reposition_widget", [w])
		_reposition_widget(w)


func _reposition_widget(wgt):
#	print("REPOSITIONING WIDGETS")
	var x = int(w/2) - (wgt.w/2)
	var y = int(h/2) - (wgt.h/2)
	wgt.set_pos(x, y, false)
#	emit_signal("repositioned")