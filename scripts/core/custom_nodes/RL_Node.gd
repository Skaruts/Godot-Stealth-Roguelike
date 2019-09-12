extends Node2D
class_name RL_Node

signal redraw_event
signal repositioned

var id := -1

var x := 0
var y := 0
var gx := 0
var gy := 0
var pos := Vector2() setget __set_pos__
var gpos:= Vector2()

var parent setget __set_parent__

################################################################################

#    setters/getters

################################################################################

func __set_pos__(pos:Vector2):      set_pos(pos.x, pos.y)

#func __set_visible__(enable:bool):
#	visible = enable
#	emit_signal("visibility_changed")
#	emit_signal("redraw_event")

func __set_parent__(p):
	parent = p
	set_pos(x, y)


################################################################################

#    internals

################################################################################

func _init(x:int, y:int):
	connect("redraw_event", core, "_on_redraw_event")
	name = "RL_Node"
	set_pos(x, y)

func draw():
	print("RL_Node.draw(): not implemented yet!")
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

func remove_child(c):
	.remove_child(c)
	c.parent = null



func set_visible(enable:bool):
	visible = enable
	emit_signal("visibility_changed")
	emit_signal("redraw_event")

