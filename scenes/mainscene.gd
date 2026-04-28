extends Node

@onready var http_request = $WordapiRequester
@onready var image_requester = $ImageRequester
@onready var image_sprite = $Image/Sprite2D

var words = []
var current_word_index = 0

func _ready():
	fetch_words()

func fetch_words():
	var url = "https://api.datamuse.com/words?sp=?????&max=100"
	http_request.request(url)

func _on_wordapi_requester_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		for item in json:
			words.append(item["word"])
		print("Fetched words: ", words)
		words.shuffle()
		spawn_next_word()
	else:
		print("Failed to fetch words")

func spawn_next_word():
	if current_word_index < words.size():
		var word_node = preload("res://scenes/Word.tscn").instantiate()
		word_node.set_word(words[current_word_index])
		word_node.position = Vector2(randi_range(-500,500), randi_range(-500, 500))
		add_child(word_node)
		current_word_index += 1
	else:
		print("All words completed!")
		
func fetch_image():
	var url = "https://randomfox.ca/floof/"
	image_requester.request(url)
		
func _on_image_requester_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		for item in json:
			words.append(item["word"])
		print("Fetched words: ", words)
		words.shuffle()
		spawn_next_word()
	else:
		print("Failed to fetch words")
