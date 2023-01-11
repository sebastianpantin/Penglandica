extends KinematicBody2D

var velocity: Vector2 = Vector2()
var direction: Vector2 = Vector2()

func read_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		direction = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		direction = Vector2(1, 0)
		
	if velocity.length() > 0:
		velocity = velocity.normalized()
		velocity = move_and_slide(velocity * 100)
	else:
		if direction.y == -1:
			$AnimatedSprite.animation = "idle_back"
		else:
			$AnimatedSprite.animation = "idle"
			
	
	if velocity.x != 0:
		if velocity.y < 0:
			$AnimatedSprite.animation = "walk_up"
		else:
			$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y > 0:
		$AnimatedSprite.animation = "walk"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "walk_up"	
	
		
func _ready():
	$AnimatedSprite.play()
	
func _physics_process(delta):
	read_input()
