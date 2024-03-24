extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		var tween_position = get_tree().create_tween()
		var tween_modulate = get_tree().create_tween()
		tween_position.tween_property(self, "position", position - Vector2(0, 100), 0.3)
		tween_modulate.tween_property(self, "modulate:a", 0, 0.3)
		body.coins += 1
		await tween_position.finished
		await tween_modulate.finished
		queue_free()
