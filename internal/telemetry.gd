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
		
func get_ipv4():
	requesting = true
	$HTTPRequest.request("https://api.ipify.org", headers, HTTPClient.METHOD_GET)

	
func requestserver(hwid, fps, godotversion, platform, ip):
	$HTTPRequest2.request('http://127.0.0.1:8000/telemetry/?hwid={hwid}&fps={fps}&gdver={godotversion}&platform={platform}&ip={ip}'.format({"hwid": hwid, "fps": fps, "godotversion": godotversion, "platform": platform,"ip": ip}), headers, HTTPClient.METHOD_POST)

func _ready():
	requestserver(OS.get_unique_id(), avgframe, get_godotversion(), OS.get_name(), ipv4)
	get_ipv4()
	
func _on_timer_timeout():
	frametime.clear()
	requestserver(OS.get_unique_id(), avgframe, get_godotversion(), OS.get_name(), ipv4)

func _on_getframetime_timeout():
	frametime.append(Engine.get_frames_per_second())
	avgframe = sum_array(frametime) / len(frametime)


func _on_http_request_request_completed(result, response_code, headers, body):
	requesting = false  
	ipv4 = body.get_string_from_utf8()
	print(ipv4)
