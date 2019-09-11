extends RL_Node
class_name RL_Control

signal mouse_enter
signal mouse_exit

signal resized
signal colors_changed



#var visible:= true setget __set_visible__
var active := true setget __set_active__

var w := 1
var h := 1
var size := Vector2(1, 1) setget __set_size__

var min_w := 1
var min_h := 1

var style:Dictionary

var fg_override:Color
var bg_override:Color

var fg:Color = core.theme.def_fg
var bg:Color = core.theme.def_bg


################################################################################

#    setters/getters

################################################################################

func __set_size__(size:Vector2):    set_size(size.x, size.y)

func __set_active__(enable:bool):
	active = enable




################################################################################

#    internals

################################################################################

func _init(x:int, y:int).(x, y):
	name = "RL_Control"


#func draw():
#	print("RL_Control.draw(): not implemented yet!")
#	assert(false)

################################################################################

#    interface

################################################################################
func set_size(new_w:int, new_h:int, emit:=true):
	w = max(new_w, min_w)
	h = max(new_h, min_h)
	size = Vector2(w, h)
	if emit:
		emit_signal("resized")
		emit_signal("redraw_event")


func set_colors(new_fg:Color, new_bg:Color, emit:=true):
	fg = new_fg
	bg = new_bg
	if emit:
		emit_signal("colors_changed")
		emit_signal("redraw_event")


func set_min_size(new_min_w:int, new_min_h:int):
	min_w = new_min_w
	min_h = new_min_h
	set_size(w, h)


#func set_active(enable:bool):
#	active = enable


func check_mouse() -> bool:
	var mpos = core.mouse_pos

	return mpos.x >= gx and mpos.x < gx+w \
	   and mpos.y >= gy and mpos.y < gy+h