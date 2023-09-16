extends Node2D

const CherryItem = preload("res://Items/cherry.tscn")



func _on_timer_timeout():
	var newCherry = CherryItem.instantiate()
	var rng = RandomNumberGenerator.new()
	
	var ranint = rng.randf_range(760,1125)
	newCherry.position = Vector2(ranint, 515)
	
	add_child(newCherry)
