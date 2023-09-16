extends Area2D

func _ready():
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	if body.name == "Player":
		body.health += 2
		
		var tween = get_tree().create_tween()
		var tweena = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 20), 0.4)
		tweena.tween_property(self, "modulate:a", 0, 0.4)
		tween.tween_callback(queue_free)
