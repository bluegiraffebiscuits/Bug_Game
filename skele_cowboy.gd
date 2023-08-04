extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const BULLET = preload("res://Bullet.tscn")

var gravity = 2100

@onready var anim = $Skeleton_Cowboy

func _physics_process(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if not is_on_floor():
		anim.play("jump")
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("move_left", "move_right")
	anim.set_flip_h(velocity.x > 0)
	if direction:
		if is_on_floor(): anim.play("walk")
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor(): anim.play("idle")
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
	move_and_slide()
	
func shoot():
	var bullet = BULLET.instantiate()
	add_child(bullet)
	bullet.set_global_position(self.get_global_position() + Vector2(10.0, 0.0))
	print(bullet.position)
	print(self.position)
		
	
	
	
