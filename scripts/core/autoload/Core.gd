extends Node
# autoLoaded script

var window_title := "StealthGameRL 0.00 - Godot 3"

var shift_mod := false
var ctrl_mod := false
var alt_mod := false

var mouse_pos := Vector2()


var TW := 20
var TH := 20
var TS := Vector2(TW, TH)

var theme = Data.def_theme


func _ready():
#	settings.load_cfg()

	seed(Data.def_settings.gen_seed.hash())
	OS.low_processor_usage_mode = true
	OS.set_window_title(window_title)
	__set_screen_size()

func _input(event:InputEvent):
	if event.is_action_pressed("quit"):
		exit()

	if event is InputEventMouseMotion:
		mouse_pos = get_viewport().get_mouse_position() / TS

	if event.is_action_pressed("key_shift"):    shift_mod = true
	elif event.is_action_released("key_shift"): shift_mod = false

	if event.is_action_pressed("key_ctrl"):	    ctrl_mod = true
	elif event.is_action_released("key_ctrl"):  ctrl_mod = false

	if event.is_action_pressed("key_alt"):      alt_mod = true
	elif event.is_action_released("key_alt"):   alt_mod = false


# in case stuff needs to be done here before quitting
func exit():
	# any other stuff here
	get_tree().quit()

func __set_screen_size():
	OS.window_size = Vector2(Data.GW, Data.GH) * TS
	OS.window_position = OS.get_screen_size()/2 - OS.window_size/2 - Vector2(0, 50)




#func __switch_font(dir):
#	if textures.switch_font(dir):
#		__set_dimensions()
#		# 0 default | 1 reverse | 2 real Time | 4 unique
#		get_tree().call_group(2, "SPRITES", "switch_font")
#		get_tree().call_group(2, "UI_ELEMENTS", "reposition")
#		__set_screen_size()




################################################################################

# 		Database

################################################################################
var _data := {}
var _nodes := {}
#var binds = {}

func add(key:String, node:Node, replace:=false):
	if _nodes.has(key):
		if replace:	_nodes[key] = node
		else: 		fail_assert("(Core) Node '%s' already exists." % [node])
	else:
		_nodes[key] = node

func get(key:String) -> Node:
	return _nodes[key] if _nodes.has(key) else null

# only the node can remove itself
func rem(key:String, node:Node):
	if _nodes.has(key) and _nodes[key] == node: _nodes.erase(key)

func has(key):
	return _nodes.has(key)

func add_var(key, val):	_data[key] = val
func get_var(key):		return _data[key] if _data.has(key) else null
func rem_var(key): 		if _data.has(key): _data.erase(key)




################################################################################

# 		Stuff

################################################################################
func error(string:String):
	var error := "\n!!! ERROR: " + string + "\n"
	print(error)
	push_error(error)


func warning(string:String):
	var warning := "\n*** WARNING: " + string + "\n"
	print(warning)
	push_warning(warning)


func fail_assert(string:String):
	print("\n\n    Assertion failed:\n\t\t " + string)
	assert(false)

func check_assert(cond:bool, string:String):
	if !cond:    fail_assert(string)

