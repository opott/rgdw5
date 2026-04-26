extends Area2D

var word: String
var typed := ""

func set_word(w: String):
	word = w
	typed = ""
	$Label.text = word

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		var c = char(event.unicode)

		if c.length() == 1 and c >= "a" and c <= "z":
			typed += c

			if word.begins_with(typed):
				update_display()

				if typed == word:
					queue_free()
					get_parent().get_node("Player").boost_jump()
			else:
				typed = ""  # reset if wrong

func update_display():
	$Label.text = word.substr(typed.length())
