extends Node

@onready var http_request: HTTPRequest = $ImageRequester
var words: Array[String] = []

func _ready() -> void:
	fetch_images()
	#fetch_words()
#
#func fetch_words() -> void:
	#var url: String = "https://random-words-api.kushcreates.com/api?words=10"
	#var err: int = http_request.request(url)
	#if err != OK:
		#push_error("HTTPRequest.request failed: %s" % err)
#
#func _on_wordapi_requester_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	#if result != HTTPRequest.RESULT_SUCCESS:
		#push_error("Request failed. result=%s code=%s" % [result, response_code])
		#return
	#if response_code != 200:
		#push_error("HTTP %s. Body(first 200): %s" % [response_code, body.get_string_from_utf8().left(200)])
		#return
#
	#var text: String = body.get_string_from_utf8()
#
	## IMPORTANT: parse_string returns Variant, so type it as Variant to avoid the warning/error.
	#var parsed: Variant = JSON.parse_string(text)
	#if typeof(parsed) != TYPE_ARRAY:
		#push_error("Expected JSON Array. Got: %s" % text.left(200))
		#return
#
	## Convert into an Array[String] of just the words
	#words.clear()
	#for item: Variant in (parsed as Array):
		#if typeof(item) == TYPE_DICTIONARY:
			#var d: Dictionary = item as Dictionary
			#if d.has("word"):
				#words.append(str(d["word"]))
#
	#spawn_words()
#
#func spawn_words() -> void:
	#for w: String in words:
		#var word_node: Node2D = preload("res://scenes/Word.tscn").instantiate()
		#word_node.set_word(w) # matches word.gd: set_word(w: String)
		#word_node.position = Vector2(randf_range(0, 800), randf_range(0, 600))
		#add_child(word_node)
		
func fetch_images():
	var url = "https://randomfox.ca/floof/"
	$ImageRequester.request(url)

func _on_image_requester_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var image_node: Node2D = preload("res://scenes/Word.tscn").instantiate()
	var json = JSON.parse_string(body.get_string_from_utf8())
	var image_url = json["image"]
	var image_request = HTTPRequest.new()
	add_child(image_request)
	image_node.texture = image_url
