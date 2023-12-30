extends Node

func _ready():
	
	get_node("Paused/Resume").visible = false
	get_node("Paused/Label").visible = false
	get_node("Paused2/Resume2").visible = false
	get_node("Paused2/Label").visible = false
	
func PauseGame() -> void:
	if Input.is_action_just_pressed("ui_pause"):
		get_node("Paused/Resume").grab_focus()
		get_tree().paused = true
		get_node("Paused/Resume").visible = true
		get_node("Paused/Label").visible = true
		
		
	if Input.is_action_just_pressed("ui_open"):
		get_node("Paused2/Resume2").grab_focus()
		get_node("Player/Camera2D").enabled = false
		get_node("Paused2/Camera2D").enabled = true
		get_node("Paused2/Resume2").visible = true
		get_node("Paused2/Label").visible = true
		get_tree().paused = true
		

func _process(delta):
		PauseGame()
	
func _on_resume_pressed():
	get_tree().paused = false
	get_node("Paused/Resume").visible = false
	get_node("Paused/Label").visible = false


func _on_resume_2_pressed():
	get_tree().paused = false
	get_node("Paused2/Resume2").visible = false
	get_node("Paused2/Label").visible = false
	get_node("Paused2/Camera2D").enabled = false
	get_node("Player/Camera2D").enabled = true
	get_node("Paused2/Label").visible = false
