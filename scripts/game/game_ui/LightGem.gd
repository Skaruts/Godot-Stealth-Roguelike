extends Node

var gem1:SK_ProgressBar
var gem2:SK_ProgressBar

var min_light = 10
var max_light = 10

func _init():
	var max_light = Data.def_settings.max_light_level
	var gem_style = { fg = Colors.WHITE, bg = Color.black }
							        #x, y,  w,  h, val,       max_val,   dir, style_override
	gem1 = ui.new_progress_bar(self, 0, 0,  1,  1, max_light, max_light, 'u', gem_style)
	gem2 = ui.new_progress_bar(self, 1, 0,  1,  1, max_light, max_light, 'u', gem_style)
	gem1.glyph = 174
	gem2.glyph = 175


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_up"):      add_light(5)
	elif Input.is_action_pressed("ui_down"):  add_light(-5)


func add_light(val:int):
	gem1.value = clamp(gem1.value+val, min_light, max_light)
	gem2.value = clamp(gem2.value+val, min_light, max_light)