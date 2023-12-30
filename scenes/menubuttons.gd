extends Button
func _ready():
	get_node("Paused2/Resume").grab_focus()
	get_node("Paused2/Resume").visible = false
	get_node("Paused2/Label").visible = false
	
func PauseGame() -> void:
	if Input.is_action_just_pressed("ui_open"):
		get_tree().paused = true
		#get_tree().change_scene_to_file("res://scenes/PauseMenu.tscn")
		get_node("Paused2/Resume").visible = true
		get_node("Paused2/Label").visible = true

func _process(delta):
	PauseGame()
	
func _on_resume_pressed():
	get_tree().paused = false
	get_node("Paused2/Resume").visible = false
	get_node("Paused2/Label").visible = false
