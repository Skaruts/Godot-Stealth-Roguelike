extends RL_Container
class_name RL_ButtonList

var buttons := []
var sorting_children := false

func _init(x:int, y:int, style_override=null).(x, y, 1, 1):
	name = "RL_ButtonList"

	if style_override:  style = style_override
	else:               style = core.theme.button

	set_size(1, 1, false)




func add_button(text:String, sig:String="", caller=null, callback:String="", args:=[]) -> RL_TextButton:
	var num_buttons:int = buttons.size()

	var b = ui.new_text_button(self, 0, num_buttons, text, style)
#	var b = RL_TextButton.new(0, num_buttons, text, style)
	add(b)
	buttons.append(b)
	if sig:
		b.connect(sig, caller, callback, args)
	b.connect("visibility_changed", self, "_sort_children")

	set_size(get_widest_button(), num_buttons+1)
	emit_signal("resized")
	return b


func get_widest_button() -> int:
	var largest_width := 0
	for btn in buttons:
		if btn.length() > largest_width:
			largest_width = btn.length()
	return largest_width


func get_button(id:int):
	return buttons[id]



func set_pos(new_x:int, new_y:int, emit:=true):
	.set_pos(new_x, new_y, false)
	if not sorting_children:
		call_deferred("_sort_children")
		sorting_children = true



func _sort_children():
#	print("SORTING CHIDREN")
	var num_buttons = buttons.size()
	var i := 0
	for b in buttons:
		if b.visible:
			b.set_pos(0, i)
			i += 1
#	emit_signal("repositioned")
	sorting_children = false
#	if i != num_buttons:
#		emit_signal("resized")
