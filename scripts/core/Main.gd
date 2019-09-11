extends Node



var pb

func _ready() -> void:
							      #x, y,  w,  h, val, max_val, dir, style_override
	pb = ui.new_progress_bar(self, 2, 2, 10,  10, 100,     100, 'd', {
		fg = Colors.RED4,
		bg = Color.black,
	})

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_up"):
		pb.value += 1
	elif Input.is_action_pressed("ui_down"):
		pb.value -= 1