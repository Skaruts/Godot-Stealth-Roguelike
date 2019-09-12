extends Node
class_name Logger


var logs := []
var num_logs := 0

func _ready():
	# load_logs()
	pass


func log_line(text:String):
	logs.append(text)
	num_logs += 1

	if logs.size() >= 32:
		num_logs = 32
		logs.pop_front()



var LOG_FILE # <- just so the editor stops complaining that it's missing
func load_logs():
	logs = Utils.get_file_lines(LOG_FILE)

func save_logs():
	Utils.save_file_lines(logs, LOG_FILE)