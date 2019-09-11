extends Node2D
class_name SK_Widget

signal redraw_event
signal mouse_enter
signal mouse_exit

signal repositioned
signal resized
signal colors_changed


var id := -1

#var visible:= true setget __set_visible__
var active := true setget __set_active__

var x := 0
var y := 0
var w := 1
var h := 1
var gx := 0
var gy := 0
var pos := Vector2() setget __set_pos__
var gpos:= Vector2()
var size := Vector2(1, 1) setget __set_size__

var min_w := 1
var min_h := 1


var style:Dictionary

var fg_override:Color
var bg_override:Color

var fg:Color = core.theme.def_fg
var bg:Color = core.theme.def_bg

var parent setget __set_parent__


################################################################################

#    setters/getters

################################################################################

func __set_pos__(pos:Vector2):      set_pos(pos.x, pos.y)
func __set_size__(size:Vector2):    set_size(size.x, size.y)

#func __set_visible__(enable:bool):
#	visible = enable
#	emit_signal("visibility_changed")
#	emit_signal("redraw_event")

func __set_active__(enable:bool):
	active = enable

func __set_parent__(p):
	parent = p
	set_pos(x, y)


################################################################################

#    internals

################################################################################

func _init(x:int, y:int):
	connect("redraw_event", core, "_on_redraw_event")
	name = "SK_Widget"
	set_pos(x, y)

func draw():
	print("SK_Widget.draw(): not implemented yet!")
	assert(false)

################################################################################

#    interface

################################################################################
func set_pos(new_x:int, new_y:int, emit:=true):
	x = new_x
	y = new_y
	gx = x if not parent else x + parent.x
	gy = y if not parent else y + parent.y

	pos = Vector2(x, y)
	gpos = Vector2(gx, gy)

#	print(type, " | ", pos, " | ", gpos)
	if emit:
		emit_signal("repositioned")
		emit_signal("redraw_event")


func add_child(w:Node, legible_unique_name:=false):
	.add_child(w, legible_unique_name)
	w.parent = self



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


func set_visible(enable:bool):
	visible = enable
	emit_signal("visibility_changed")
	emit_signal("redraw_event")

#func set_active(enable:bool):
#	active = enable


func check_mouse() -> bool:
	var mpos = core.mouse_pos

	return mpos.x >= gx and mpos.x < gx+w \
	   and mpos.y >= gy and mpos.y < gy+h