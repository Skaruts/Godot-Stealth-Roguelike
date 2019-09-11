extends Node
# autoloaded script

var _wid := -1    # widget id
var _widgets := []
var _dirty_widgets := []

# TODO: implement recycling free ids
func _next_wid() -> int:
	_wid += 1
	return _wid


var redrawing := false

#func _on_draw_event():
#	core.redraw()
#	if not redrawing:
#		call_deferred("draw")
#		redrawing = true

func draw():
	redrawing = false
	for w in _widgets:
		if w.visible:
			w.draw()



################################################################################

#    Widget Factory

################################################################################
func add(w:RL_Control, parent:Node):
	if not _widgets.has(w):
#		w.connect("redraw_event", core, "_on_redraw_event")
		w.id = _next_wid()
		parent.add_child(w)
		_widgets.append(w)

func del(w:RL_Control, parent:Node):
	if _widgets.has(w):
		_widgets.erase(w)


func new_label(parent, x:int, y:int, text:String, style_override=null) -> RL_Label:
	var l = RL_Label.new( x, y, text, style_override )
	add(l, parent)
	return l

#func new_icon(parent, x:int, y:int, icon:int=0, style_override=null) -> RL_Icon:
#	var i = RL_IconButton.new( x, y, icon, style_override )
#	i.id = _next_wid()
#	parent.add_child(i)
#	return i

func new_button(parent, x:int, y:int, text:String="", icon:int=0, style_override=null) -> RL_Button:
	var b = RL_Button.new( x, y, text, icon, style_override )
	add(b, parent)
	return b

func new_icon_button(parent, x:int, y:int, icon:int=0, style_override=null) -> RL_IconButton:
	var b = RL_IconButton.new( x, y, icon, style_override )
	add(b, parent)
	return b

func new_text_button(parent, x:int, y:int, text:String="", style_override=null) -> RL_TextButton:
	var b = RL_TextButton.new( x, y, text, style_override )
	add(b, parent)
	return b

func new_button_list(parent, x:int, y:int, style_override=null) -> RL_ButtonList:
	var bl = RL_ButtonList.new( x, y, style_override )
	add(bl, parent)
	return bl

func new_frame(parent, x:int, y:int, w:int, h:int, style_override=null) -> RL_Frame:
	var f = RL_Frame.new( x, y, w, h, style_override )
	add(f, parent)
	return f

func new_center_container(parent, x:int, y:int, w:int, h:int) -> RL_CenterContainer:
	var cc = RL_CenterContainer.new( x, y, w, h )
	add(cc, parent)
	return cc


func new_h_separator(parent, x:int, y:int, w:int, style_override=null) -> RL_HSeparator:
	var s = RL_HSeparator.new( x, y, w, style_override )
	add(s, parent)
	return s

func new_v_separator(parent, x:int, y:int, h:int, style_override=null) -> RL_VSeparator:
	var s = RL_VSeparator.new( x, y, h, style_override )
	add(s, parent)
	return s

func new_progress_bar(parent, x:int, y:int, w:int, h:int, val:int, max_val:int, dir:String, style_override=null) -> RL_ProgressBar:
	var pb = RL_ProgressBar.new( x, y, w, h, val, max_val, dir, style_override )
	add(pb, parent)
	return pb
