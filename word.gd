extends Sprite2D

var word: String
var typed = ""

func set_word(w: String):
	word = w
	$Label.text = word
	
func _input(event):
	if event is InputEventKey and event.pressed:
		var char = char(event.unicode)
		if char.is_valid_identifier():
			typed += char
			update_display()
			if typed == word:
				queue_free()
				get_parent().get_node("Player").boost_jump()
				
func update_display():
	$Label.text = word.substr(typed.length())
