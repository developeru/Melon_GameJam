extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var canDoubleJump = false
var enableGlide = false
var enableLatching = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var limit = 0
var playerGravity = gravity

@onready var animPlayer = get_node("AnimationPlayer") #Gets the AnimationPlayer node once the node has loaded
@onready var animSprite = get_node("AnimatedSprite2D") #Gets the AnimationSprite node once the node has loaded

@onready var world =  get_tree().get_root().get_node("World")
var isInsideB1 := false
var isInsideB2 := false
var isInsideB3 := false

var goToNextLevel := false

var reloadScene2 := false

func _ready():
	isInsideB1 = false
	isInsideB2 = false
	
func _on_beacon_1_body_entered(body):
	isInsideB1 = true
	print("?")

func _on_beacon_1_body_exited(body):
	isInsideB1 = false
	print("??")
	
func _on_beacon_2_body_entered(body):
	isInsideB2 = true
	print("???")
	
func _on_beacon_2_body_exited(body):
	isInsideB2 = false
	print("????")

func _on_beacon_3_body_entered(body):
	isInsideB3 = true
	print("Works?")
func _on_beacon_3_body_exited(body):
	isInsideB3 = false
	

func MakeStatic():
	playerGravity = 0
	velocity.x = 0
	velocity.y = 0



func _process(delta):
		if limit == 0:
			isInsideB1 = false
			isInsideB2 = false
			isInsideB3 = false
			goToNextLevel = false
			reloadScene2 = false
			limit = 1
		
	
		if Input.is_action_just_pressed("ui_charm") && (isInsideB1 || isInsideB2 || isInsideB3):
			
			if isInsideB1:
				world.isB1Activated = true
				
			if isInsideB2:
				world.isB2Activated = true
			
			if isInsideB3:
				print("Sim senhora")
				world.isB3Activated = true
				
		if goToNextLevel:
			get_tree().change_scene_to_file("res://scenes/level3.tscn")
		
		if reloadScene2:
			transform.origin.x = 5
			transform.origin.y = -335
			reloadScene2= false
	
func _physics_process(delta):
	
	var leftray = get_node("RayCast2D2")
	var rightray = get_node("RayCast2D")
	
	#Checks for prompt to latch
	if (leftray.is_colliding() || rightray.is_colliding()) && (Input.is_action_just_pressed("ui_latch") || Input.is_action_pressed("ui_latch")):
		enableLatching = true
		
	if Input.is_action_just_released("ui_latch"):
		enableLatching = false
		canDoubleJump = true
		playerGravity = gravity
		
	# Add the gravity.
	if not is_on_floor():
		if enableGlide && velocity.y >= 0: #checks if the player has double jumped and if he's started falling
			playerGravity /= 10
			enableGlide = false 
		velocity.y += playerGravity * delta
		
	# Handles jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		playerGravity = gravity
		velocity.y = JUMP_VELOCITY
		canDoubleJump = true
	
	if Input.is_action_just_pressed("ui_downc"):
		playerGravity = gravity
	
	if canDoubleJump && Input.is_action_just_pressed("ui_up") && !is_on_floor() && !enableLatching:
		velocity.y = JUMP_VELOCITY
		canDoubleJump = false
		enableGlide = true

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if direction > 0:
			animSprite.flip_h = false
			animPlayer.play("Run")
		else:
			animSprite.flip_h = true
			animPlayer.play("Run")
			
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animPlayer.play("Idle")
	#Latches the player onto the surface
	if enableLatching:
		MakeStatic() #Cancels all forces suffered by the player
		
	move_and_slide()


func _on_teleport_body_entered(body):
	goToNextLevel = true

func _on_bottom_body_entered(body):
	reloadScene2 = true




