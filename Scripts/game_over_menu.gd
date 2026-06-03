extends CanvasLayer

func _ready() -> void:
	hide()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()



func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
func show_game_over(winner_text: String) -> void:
	$PanelContainer/VBoxContainer/Label.text = winner_text
	show()
