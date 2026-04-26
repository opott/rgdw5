extends Node

@onready var http_request = $WordapiRequester
var words = []

func _ready():
	fetch_words()

func fetch_words():
	var url = "https://api.datamuse.com/words?sp=?????&max=10"  # Adjust for more words
	http_request.request(url)

func _on_wordapi_requester_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		for item in json:
			words.append(item["word"])
		print("Fetched words: ", words)
		# now, spawn word objects in the game
		spawn_words()
	else:
		print("Failed to fetch words")

func spawn_words():
	for word in words:
		# create a word node (we'll define this next)
		var word_node = preload("res://scenes/Word.tscn").instantiate()
		word_node.set_word(word)
		word_node.position = Vector2(randf_range(0, 800), randf_range(0, 600))  # random position
		add_child(word_node)
