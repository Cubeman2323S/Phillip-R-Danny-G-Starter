extends CharacterBody2D
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D

var xSpeed = 300.0
var xDirection = 0
var facing = "down"
var ySpeed = 300.0
var yDirection = 0
var coins = 0
var health = 100
var max_health = 100

var projectile_scene = preload("res://scenes/projectile.tscn")

func _physics_process(_delta):
	xDirection = Input.get_axis("ui_left", "ui_right")
	yDirection = Input.get_axis("ui_up", "ui_down")
	velocity.x = xSpeed * xDirection
	velocity.y = ySpeed * yDirection

	if xDirection == 1:
		facing = "right"
	elif xDirection == -1:
		facing = "left"
	elif yDirection == -1:
		facing = "up"
	elif yDirection == 1:
		facing = "down"
		
	if Input.is_action_just_pressed("ui_select"):
		shoot()
	
	move_and_slide()
	update_animation()

func update_animation():
	
	
		
	if xDirection == 0 and yDirection == 0:
		_animation_player.play("idle_" + facing)
	else:
		_animation_player.play("walk_" + facing)
		
	pass

func change_health(amount):
	print("Health changed by: ", amount)
	health += amount
	if health>max_health:
		health = max_health
	if health<1:
		queue_free()
	
	


# TODO: Create shooting function
func shoot():
	# TODO: Create a new projectile instance
	# Look at the documentation examples in the lesson
	var new_instance = projectile_scene.instantiate()
	new_instance.set_direction(facing)
	get_parent().add_child(new_instance)
	new_instance.global_position = position - Vector2(0,25)
	
	# TODO: Set projectile position to player position
	# Look at the "Setting Object Position" example
	
	
	# TODO: Set projectile direction using facing variable
	# Look at the "Calling Functions on Other Objects" example
	
	
	# TODO: Add projectile to the game world
	# Look at the "Adding Objects to the Game World" example
	
	
	# TODO: Print shooting confirmation
	# print("Shot projectile facing: ", facing)
	
	pass
func change_coins(amount:int):
	coins+=amount
	print("Coins: " + str(coins))
