extends Node2D
# autoloaded script


var GW:int = Data.GW
var GH:int = Data.GH
var _cellmap = Array()

func _init():
	_init_cellmap()


func _init_cellmap():
	var tex = preload("res://data/fonts/cp437_20x20.png")
	var shader = preload("res://resources/cell_shader.shader")

	for j in range(GH):
		_cellmap.append([])
		for i in range(GW):
			var cell = Sprite.new()
			add_child( cell )
			_cellmap[j].append(cell)

			cell.centered = false
			cell.texture = tex

			cell.hframes = 16
			cell.vframes = 16
			cell.frame = 0

			var mat = ShaderMaterial.new()
			mat.shader = shader
			mat.set_shader_param( "fg", Data.DEF_FG )
			mat.set_shader_param( "bg", Data.DEF_BG )
			cell.material = mat

			cell.position = Vector2(i, j) * core.TS
			cell.visible = false




func _ascii(ch):
	return ch[0].to_ascii()[0]

#-------------------------------------------------------------------------------
#		Interface
#-------------------------------------------------------------------------------
func clear():
	# TODO: could speed this up by caching visible cells?
	for j in range(GH):
		for i in range(GW):
			_cellmap[j][i].visible = false


func put(x:int, y:int, glyph, fg:Color=Data.DEF_FG, bg:Color=Data.DEF_BG):
	if x >= 0 and x < GW and y >= 0 and y < GH:
		if typeof(glyph) == TYPE_STRING:
			glyph = _ascii(glyph)

		_cellmap[y][x].visible = true
		_cellmap[y][x].frame = glyph
		_cellmap[y][x].get_material().set_shader_param("fg", fg)
		_cellmap[y][x].get_material().set_shader_param("bg", bg)


func del(x:int, y:int):
	if x >= 0 and x < GW and y >= 0 and y < GH:
		_cellmap[y][x].visible = false


func batch(x:int, y:int, array:Array, fgs:Array, bg:Color=Data.DEF_BG):
	var h = array.size()
	var w = array[0].size()

	# check if the array is not totally outside the screen bounds
	if x < GW and y < GH and x+w > 0 and y+h > 0:
		for j in range(h):
			for i in range(w):
				var xi = x+i
				var yj = y+j

				if  xi >= 0 and xi < GW \
				and yj >= 0 and yj < GH:
					var glyph = array[j][i]
					if glyph and glyph >= 0:
						_cellmap[yj][xi].visible = true
						_cellmap[yj][xi].frame = glyph
						_cellmap[yj][xi].get_material().set_shader_param("fg", fgs[j][i])
						_cellmap[yj][xi].get_material().set_shader_param("bg", bg)



func printl(x:int, y:int, text:String, fg:Color=Data.DEF_FG, bg:Color=Data.DEF_BG):
	var length = text.length()
	var barray = text.to_ascii()

	if x < GW and y < GH and x+length >= 0 and y >= 0:
		for i in range( text.length() ):
			var xi = x+i
			if x+i >= 0 and xi < GW:
				_cellmap[y][xi].visible = true
#				_cellmap[y][xi].frame = Utils.ascii(text[i])
				_cellmap[y][xi].frame = barray[i]	# if using to_ascii()

				_cellmap[y][xi].get_material().set_shader_param("fg", fg)
				_cellmap[y][xi].get_material().set_shader_param("bg", bg)

