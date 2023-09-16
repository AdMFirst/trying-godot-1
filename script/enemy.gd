extends CharacterBody2D

const speed = 50
const jump_speed = -200

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chasing = null

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):	
	if $AnimatedSprite2D.animation != "death":
		if velocity.x != 0:
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("idle")
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if chasing:
		var direction = (chasing.position - global_position).normalized()
		velocity.x = direction.x * speed
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
		elif direction.x < 0:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func _on_p_layerdetection_body_entered(body):
	if body.name == "Player":
		chasing = body
		


func _on_p_layerdetection_body_exited(body):
	if body.name == "Player":
		chasing = null


func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()
		Game.playerGold += 5
		Utils.saveGame()


func _on_attack_player_body_entered(body):
	if body.name == "Player":
		body.health -= 1
		death()
		

func death():
	chasing = null
	$AnimatedSprite2D.play("death")
	await $AnimatedSprite2D.animation_finished
	queue_free()
