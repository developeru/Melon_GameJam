extends Node

var startedCountdown := false
var isB1Activated := false
var isB2Activated := false
var hasWon := false

@onready var timer = get_node("Timer")

@onready var audiostream = get_node("AudioStreamPlayer")
var finishedLevel := false



func _ready():
	
	get_node("Paused/Resume").visible = false
	get_node("Paused/Label").visible = false
	get_node("Paused2/Resume2").visible = false
	get_node("Paused2/Label").visible = false
	
	
	get_node("BGC").visible = false
	get_node("BGC2").visible = false
	get_node("BGCMain").visible = false

	
# Pausing
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
		#if isB1Activated:
			#print("isB1Activated:" + str(isB1Activated))
			#
		#if isB2Activated:
			#
			#print("isB2Activated:" + str(isB2Activated))
		PauseGame() #Pause
		
		if audiostream.playing == false:
				audiostream.play()
		if !hasWon:
			if isB1Activated: #Timer
				
				if !startedCountdown:
					startedCountdown = true
					timer.start()
					get_node("BGC2").visible = true
					print("works?")
					
				else:
					if isB2Activated:
						hasWon = true
						get_node("CanvasLayer/TimerL").text = "You finished the tutorial! Press ENTER to progress to level 1."
					
					
			if isB2Activated:
				if !startedCountdown:
					startedCountdown = true
					timer.start()
					get_node("BGC").visible = true
					print("Workd!?")
				else:
					if isB1Activated:
						hasWon = true
						
					
			if startedCountdown:
				get_node("CanvasLayer/TimerL").visible = true
				get_node("CanvasLayer/TimerL").text = "Time left: " + str(ceil(timer.time_left))
		else:
			timer.stop()
			timer.emit_signal("timeout")
			#get_node("Player/Camera2D").enabled = false
			#get_node("Paused2/Camera2D").enabled = true
			get_node("BGCMain").visible = true
			finishedLevel = true
			
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

#Timer
func _on_timer_timeout():
	startedCountdown = false
	isB1Activated = false
	isB2Activated = false
	if !hasWon:
		get_node("CanvasLayer/TimerL").visible = false
	


