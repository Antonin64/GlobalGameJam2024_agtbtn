extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const url_submit = "https://docs.google.com/forms/u/0/d/e/1FAIpQLScLVNU7gi48d_qQT_Veb4QBUtRqxJjtG-o_m-DEysuA3IMQAA/formResponse"
const headers = ["Content-Type: application/x-www-form-urlencoded"]
var client = HTTPClient.new()

func http_submit(result, response_code, headers, body, http):
	http.queue_free()
	pass

func add_score(lvl_time, lvl):
	var http = HTTPRequest.new()
	http.connect("request_completed", http_submit, 0)
	add_child(http)
	
	var user_data = client.query_string_from_dict({
		"entry.1996424206": Global.username,
		"entry.1284922852": lvl_time,
		"entry.991293941": lvl
	})
	var err = http.request(url_submit, headers, HTTPClient.METHOD_POST, user_data)
	if err:
		http.queue_free()
		print("html error !")
		
