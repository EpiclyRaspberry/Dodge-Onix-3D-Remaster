extends Node

var requesting = true
var ipv4
var headers = ["User-Agent: DodgeOnix3DUSER"]
var frametime = []
var avgframe

func sum_array(array):
	var sum = 0.0
	for element in array:
		sum += element
	return sum

func get_godotversion():
	return "{major}.{minor}".format({"major" :str(Engine.get_version_info().major),"minor": str(Engine.get_version_info().minor)})
	# this shit is terrible dont touch this

		
func requestserver(hwid, fps, godotversion, platform):
	$HTTPRequest2.request('http://188.166.176.130:8000/telemetry/?hwid={hwid}&fps={fps}&gdver={godotversion}&platform={platform}'.format({"hwid": hwid, "fps": fps, "godotversion": godotversion, "platform": platform}), headers, HTTPClient.METHOD_POST)

func _ready():
	requestserver(OS.get_unique_id(), avgframe, get_godotversion(), OS.get_name())
	
func _on_timer_timeout():
	frametime.clear()
	requestserver(OS.get_unique_id(), avgframe, get_godotversion(), OS.get_name())

func _on_getframetime_timeout():
	frametime.append(Engine.get_frames_per_second())
	avgframe = sum_array(frametime) / len(frametime)


func _on_http_request_request_completed(result, response_code, headers, body):
	requesting = false  
	ipv4 = body.get_string_from_utf8()
