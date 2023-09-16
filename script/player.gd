extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = 3

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	var diry = Input.get_axis("ui_up", "ui_down")
	if diry < -0.499 and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$PlayerAnimation.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			$PlayerAnimation.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			$PlayerAnimation.play("idle")
	
	# check for looking left or right
	if direction == -1:
		$PlayerAnimation.flip_h = true
	elif direction == 1:
		$PlayerAnimation.flip_h = false
		
	# chock if falling
	if velocity.y > 0:
		$PlayerAnimation.play("fall")

	move_and_slide()
	
	if health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://Scene/main.tscn")
