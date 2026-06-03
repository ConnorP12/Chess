extends CanvasLayer

func _ready() -> void:
	# Hide the menu by default when the game starts
	hide()

# Connect the Button's "pressed" signal to this function
func _on_restart_button_pressed() -> void:
	# Reload the current active scene
	get_tree().reload_current_scene()

# Call this function from your main chess game script when someone wins


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
func show_game_over(winner_text: String) -> void:
	$PanelContainer/VBoxContainer/Label.text = winner_text
	show()
