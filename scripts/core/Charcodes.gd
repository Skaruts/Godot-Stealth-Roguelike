extends Node
class_name Charcodes

const CHECK_BTN_CHECKED := 254
const CHECK_BTN_UNCHECKED := 255

# char/glyphs values
# -------------------------
const WALL    := 35 # '#'
const FLOOR   := 46 # '.'
const DOORC   := 43 # '+'
const DOORO   := 46 # '.' use the other dot (249)
const TORCHL  := 39 # '´'
const TORCHR  := 96 # '`'
const TORCHF  := 173 # (floor torch) upside-down '!'

const PLAYER  := 64 # '@'
const HUMAN   := 44 # 'h'
const ORC     := 111 # 'o'
const TROLL   := 116 # 't'

const CORPSE  := 38 # '&'

const HP_BAR := 254

const PL_STANCE := [95, 229, 227]
const PL_SPEED  := [124, 41, 47]
# drawing lines
# -------------------------
# thin lines
# drawing lines
const thin_lines = {
	HL = 196,
	VL = 179,
	TL = 218,   # Top Left
	TR = 191,   # Top Right
	BL = 192,   # Bottom Left
	BR = 217,   # Bottom Right
	LJ = 195,   # Left T-junction/Cap
	RJ = 180,   # Right T-junction/Cap
	TJ = 194,   # Top T-junction/Cap
	BJ = 193,   # Bottom T-unction/Cap
	XJ = 197    # Cross Junction (or Full Block?)
}

const thick_lines = {
	HL2 = 205,
	VL2 = 186,
	TL2 = 201,
	TR2 = 187,
	BL2 = 200,
	BR2 = 188,
	LJ2 = 204,
	RJ2 = 185,
	TJ2 = 203,
	BJ2 = 202,
	XJ2 = 206
}

const FB := 219
const LB := 221
const RB := 222
const TB := 223
const BB := 220

const CAP := 255
