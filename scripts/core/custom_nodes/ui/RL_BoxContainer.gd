extends RL_Container
class_name RL_BoxContainer



func _init(x:int, y:int, w:int, h:int).(x, y, w, h):
	name = "RL_BoxContainer"
	connect("sort_children", self, "_on_sort_children")


func add_child(c, legible_unique_name:=false):
	.add_child(c)
	emit_signal("sort_children")


func _process(delta: float) -> void:
	_sort_children()
	set_process(false)

func _on_sort_children():
	set_process(true)

var vertical := false

func _sort_children():
	# gather visible controls
	var visible_controls := []
	for c in _controls:
		if c.visible:
			visible_controls.append(c)

	var num_controls = visible_controls.size()
	var num_controls_left:int = num_controls
	var space_taken:int = 0
	var remainder:int = 0
	var div:int
	var space_left:int

	if vertical:
		div = h/num_controls
		space_left = h-space_taken

		for i in range(num_controls):
			var c = visible_controls[i]
			if not c.expand_v or c.min_h > div:
				space_taken += c.min_h
				num_controls_left -= 1
		space_left = h-space_taken
	else:
		div = w/num_controls
		space_left = w-space_taken

		for i in range(num_controls):
			var c = visible_controls[i]
			if not c.expand_h or c.min_w > div:
				space_taken += c.min_w
				num_controls_left -= 1
		space_left = w-space_taken

	remainder = 0
	if num_controls_left > 0:
		remainder = space_left%num_controls_left
		div = space_left/num_controls_left


	# TODO:
	#	SOME CONTROLS ARE EXCLUDED FROM THE FIRST CALCULATION BECAUSE THEY ARE
	#   BIGGER THAN THE FIRST DIV
	#   BUT THEN THEY'RE SMALLER THAN THE LAST DIV, AND IF SET TO EXPAND
	#   THEY'LL TAKE TOO MUCH SPACE
	#   DIV NEEDS TO BE CALCULATED AGAIN WITH THAT IN MIND?
	#   (IT COULD STILL HAPPEN AFTER THE SECOND CALCULATION)



	# set all their positions and sizes
	if vertical:
		for i in range(num_controls):
			var c = visible_controls[i]

			if i > 0: c.y = visible_controls[i-1].y + visible_controls[i-1].h
			else:     c.y = y
											# set x an width
			if c.expand_h:
				c.w = max(w, c.min_w)
				c.x = x
			else:
				c.w = c.min_w
				c.x = x+w/2 - c.w/2
											# set height
			if c.expand_v:
	#			if not i in skips:
				c.h = max(div, c.min_h)

				if remainder > 0 and div > c.min_h:
					c.h += 1
					remainder -= 1
			else:
				c.h = c.min_h

			c.emit_signal("resized")

			print("c: %d/%d | h:%2d | DIV: %2d | min_h: %2d | remainder: %2d" % \
					[num_controls_left, num_controls, c.h, div, c.min_h, remainder])

	else:
		for i in range(num_controls):
			var c = visible_controls[i]
											# set x
			if i > 0: c.x = visible_controls[i-1].x + visible_controls[i-1].w
			else:     c.x = x
											# set y an height
			if c.expand_v:
				c.h = max(h, c.min_h)
				c.y = y
			else:
				c.h = c.min_h
				c.y = y+h/2 - c.h/2
											# set width
			if c.expand_h:
	#			if not i in skips:
				c.w = max(div, c.min_w)

				if remainder > 0 and div > c.min_w:
					c.w += 1
					remainder -= 1
			else:
				c.w = c.min_w

			c.emit_signal("resized")

			print("c: %d/%d | w:%2d | DIV: %2d | min_w: %2d | remainder: %2d" % \
					[num_controls_left, num_controls, c.w, div, c.min_w, remainder])

#	emit_signal("resized")
	emit_signal("redraw_event")
	pass

