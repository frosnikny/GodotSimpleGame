extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animatedSprite = $AnimatedSprite2D # get_node("AnimatedSprite2D")
var health = 100
var coins = 0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			animatedSprite.play("Fall")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if velocity.y < 0:
			animatedSprite.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
		if direction == -1:
			animatedSprite.flip_h = true
		else:
			animatedSprite.flip_h = false
		
		if !velocity.y:
			animatedSprite.play("Run")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if !velocity.y:
			animatedSprite.play("Idle")
	

	move_and_slide()
