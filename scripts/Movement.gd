extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var canDoubleJump = false
var enableGlide = false
var enableLatching = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var playerGravity = gravity

@onready var animPlayer = get_node("AnimationPlayer") #Gets the AnimationPlayer node once the node has loaded
@onready var animSprite = get_node("AnimatedSprite2D") #Gets the AnimationSprite node once the node has loaded

func MakeStatic():
	playerGravity = 0
	velocity.x = 0
	velocity.y = 0

	
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

