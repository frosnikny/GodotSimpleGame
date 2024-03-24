extends CharacterBody2D

const SPEED = 200

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animatedSprite = $AnimatedSprite2D
var chase = false

var alive = true
enum deathType {DEATH_ATTACK, DEATH_EXPLODE, DEATH_HIT}

func death(type: deathType = deathType.DEATH_ATTACK):
	alive = false
	
	match type:
		deathType.DEATH_EXPLODE:
			animatedSprite.play("Explode")
		#deathType.DEATH_ATTACK:
			#animatedSprite.play("Death")
		#deathType.DEATH_HIT:
			#animatedSprite.play("Explode")
		_:
			animatedSprite.play("Death")
	await animatedSprite.animation_finished
	
	queue_free()
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# TODO: problem with the level tree (it always should be the same)
	var player = $"../../Player/Player"
	var direction = (player.position - self.position).normalized()
	if chase && alive:
		velocity.x = direction.x * SPEED
		if direction.x < 0:
			animatedSprite.flip_h = true
		elif direction.x > 0:
			animatedSprite.flip_h = false
	else:
		velocity.x = 0

	move_and_slide()


func _on_detector_body_entered(body):
	if body.name == "Player":
		chase = true
		animatedSprite.play("Walk")


func _on_un_detector_body_exited(body):
	if body.name == "Player":
		chase = false
		animatedSprite.play("Idle")


func _on_explosion_area_body_entered(body):
	if body.name == "Player":
		if alive:
			death(deathType.DEATH_EXPLODE)
			body.health -= 40
		
