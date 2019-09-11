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

#func draw():
#	redrawing = false
#	for w in _widgets:
#		if w.visible:
#			w.draw()



################################################################################

#    Widget Factory

################################################################################
func add(w:SK_Widget, parent:Node):
	if not _widgets.has(w):
		w.id = _next_wid()
		parent.add_child(w)
#		_widgets.append(w)
#		w.connect("redraw_event", self, "_on_draw_event")

func del(w:SK_Widget, parent:Node):
	if _widgets.has(w):
		_widgets.erase(w)


func new_label(parent, x:int, y:int, text:String, style_override=null) -> SK_Label:
	var l = SK_Label.new( x, y, text, style_override )
	add(l, parent)
	return l

#func new_icon(parent, x:int, y:int, icon:int=0, style_override=null) -> SK_Icon:
#	var i = SK_IconButton.new( x, y, icon, style_override )
#	i.id = _next_wid()
#	parent.add_child(i)
#	return i

func new_button(parent, x:int, y:int, text:String="", icon:int=0, style_override=null) -> SK_Button:
	var b = SK_Button.new( x, y, text, icon, style_override )
	add(b, parent)
	return b

func new_icon_button(parent, x:int, y:int, icon:int=0, style_override=null) -> SK_IconButton:
	var b = SK_IconButton.new( x, y, icon, style_override )
	add(b, parent)
	return b

func new_text_button(parent, x:int, y:int, text:String="", style_override=null) -> SK_TextButton:
	var b = SK_TextButton.new( x, y, text, style_override )
	add(b, parent)
	return b

func new_button_list(parent, x:int, y:int, style_override=null) -> SK_ButtonList:
	var bl = SK_ButtonList.new( x, y, style_override )
	add(bl, parent)
	return bl

func new_frame(parent, x:int, y:int, w:int, h:int, style_override=null) -> SK_Frame:
	var f = SK_Frame.new( x, y, w, h, style_override )
	add(f, parent)
	return f

func new_center_container(parent, x:int, y:int, w:int, h:int) -> SK_CenterContainer:
	var cc = SK_CenterContainer.new( x, y, w, h )
	add(cc, parent)
	return cc


func new_h_separator(parent, x:int, y:int, w:int, style_override=null) -> SK_HSeparator:
	var s = SK_HSeparator.new( x, y, w, style_override )
	add(s, parent)
	return s

func new_v_separator(parent, x:int, y:int, h:int, style_override=null) -> SK_VSeparator:
	var s = SK_VSeparator.new( x, y, h, style_override )
	add(s, parent)
	return s