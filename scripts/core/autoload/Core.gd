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


enum State { INPUT, UPDATE, DRAW }
var _current_state:int = State.INPUT

func _ready():
#	settings.load_cfg()
	seed(Data.def_settings.gen_seed.hash())
	OS.low_processor_usage_mode = true
	OS.set_window_title(window_title)
	VisualServer.set_default_clear_color( Color.black )

	_set_tile_size()
	_set_screen_size()


func _process(delta: float) -> void:
	match _current_state:
		State.UPDATE:
			pass
			_current_state = State.DRAW
		State.DRAW:
			terminal.clear()
			ui.draw()
			_current_state = State.INPUT
		State.INPUT:
			set_process(false)

func _on_redraw_event():
	set_process(true)
	_current_state = State.DRAW

func _input(event:InputEvent):
	if event is InputEventMouseMotion:
		mouse_pos = get_viewport().get_mouse_position() / TS

	elif event.is_action_pressed("quit"):
		exit()

	elif event.is_action_pressed("key_shift"):  shift_mod = true
	elif event.is_action_released("key_shift"): shift_mod = false

	elif event.is_action_pressed("key_ctrl"):	ctrl_mod = true
	elif event.is_action_released("key_ctrl"):  ctrl_mod = false

	elif event.is_action_pressed("key_alt"):    alt_mod = true
	elif event.is_action_released("key_alt"):   alt_mod = false

	elif event.is_action_pressed("next_font"):  _switch_font( 1)
	elif event.is_action_pressed("prev_font"):  _switch_font(-1)


# shorthand for 'get_tree().quit()'; also in case anything has to be done before quitting
func exit():
	# any other stuff here
	get_tree().quit()

func _set_screen_size():
	OS.window_size = Vector2(Data.GW, Data.GH) * TS
	OS.window_position = OS.get_screen_size()/2 - OS.window_size/2 - Vector2(0, 50)


func _set_tile_size():
	TS = am.get_font_size()
	TW = TS.x
	TH = TS.y


func _switch_font(dir):
	am.switch_font(dir)
	_set_tile_size()
	_set_screen_size()
	terminal.switch_font()





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

