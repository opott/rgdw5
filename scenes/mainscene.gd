extends Node

@onready var http_request = $WordapiRequester
var words = []

func _ready():
	fetch_words()
	
func fetch_words():
	var url = "https://random-words-api.kushcreates.com/api"
	http_request.request(url)
	
func _on_wordapi_requester_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		words = json
		print("Fetched words: ", words)
		spawn_words()
	else:
		print("Failed to fetch words")
		
func spawn_words():
	for word in words:
		var word_node = preload("res://scenes/Word.tscn").instantiate()
		word_node.set_word(word)
		word_node.position = Vector2(randf_range(0, 800), randf_range(0, 600))
		add_child(word_node)
