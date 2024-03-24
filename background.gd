extends ParallaxBackground

var speed = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# delta - чтобы под разную частоту кадров подстроиться
	scroll_offset.x -= speed * delta
