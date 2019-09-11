extends SK_Widget
class_name SK_Container

var _widgets := []

func _init(x:int, y:int, w:int, h:int).(x, y):
	name = "Container"

	set_size(w, h)

func draw():
	if visible:
		for w in _widgets:
			if w.visible:
				w.draw()

func input(event:InputEvent):
	if visible and active:
		for w in _widgets:
			if w.visible and w.active:
				w.input(event)

func add(w):
	if not _widgets.has(w):
		_widgets.append(w)
#		add_child(w)


func del(w):
	if _widgets.has(w):
		_widgets.erase(w)
		w.queue_free()


#func set_visible(enable:bool, emit:=true):
#	.set_visible(enable, false)
#	for w in _widgets:
#		w.set_visible(enable, false)

#	emit_signal("visibility_changed")


func set_active(enable:bool):
	.set_active(enable)
	for w in _widgets:
		w.active = enable