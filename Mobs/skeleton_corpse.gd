extends Area2D

@onready var animatedSprite = $AnimatedSprite2D

var skeleton_preload = preload("res://Mobs/skeleton.tscn")

func skeleton_spawn():
	var skeleton = skeleton_preload.instantiate()
	# TODO: problem with the level tree (it always should be the same)
	skeleton.position = $"..".position
	$"../..".add_child(skeleton)
	
func _ready():
	$GenerationTimer.start()


func _on_generation_timer_timeout():
	$GenerationTimer.stop()
	animatedSprite.play("Generation 1_1")
	$RebornPartTimer.start()


func _on_reborn_part_timer_timeout():
	$RebornPartTimer.stop()
	animatedSprite.play("Generation 1_2")
	$RebornEndTimer.start()


func _on_reborn_end_timer_timeout():
	$RebornEndTimer.stop()
	animatedSprite.play("Reborn")
	await animatedSprite.animation_finished
	await skeleton_spawn()
	queue_free()

