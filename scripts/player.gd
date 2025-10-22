extends CharacterBody2D
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D
var projectile_original = preload("res://scenes/projectile.tscn")
var xSpeed = 300.0
var xDirection = 0
var facing = "down"
var ySpeed = 300.0
var yDirection = 0
var coins = 0
@export var offset : Vector2 = Vector2(0, -25)
@onready var melee_box : CollisionShape2D = $Area2D/CollisionShape2D
var maxHealth = 10
var health = maxHealth
var is_attacking = false
var attack_timer = .6
var current_enemy 
var player_in_range=false

func _ready() -> void:
	pass

func _physics_process(_delta):
	xDirection = Input.get_axis("ui_left", "ui_right")
	yDirection = Input.get_axis("ui_up", "ui_down")
	velocity.x = xDirection * xSpeed
	velocity.y = yDirection * ySpeed
	if xDirection > 0:
		facing = "right"
		melee_box.position = Vector2(30,-10)
	elif xDirection < 0:
		facing = "left"
		melee_box.position = Vector2(-30,-10)
	elif yDirection < 0:
		facing = "up"
		melee_box.position = Vector2(0,-40)
	elif yDirection > 0:
		facing = "down"
		melee_box.position = Vector2(0,20)
	if Input.is_action_just_pressed("KEY_F"):
		shoot()
		print("ranged")
	if Input.is_action_just_pressed("ui_select"):
		print("melee")
		if is_attacking == false:
			is_attacking = true
			print("attack")
	if is_attacking:
		attack_timer -= _delta
	if attack_timer < 0:
		print("attack_end")
		is_attacking = false
		attack_timer = .66
	if is_attacking and current_enemy != null:
		print("should die")
		current_enemy.queue_free()
	update_animation()
	move_and_slide()

func update_animation():
	if is_attacking:
		_animation_player.play("attack_"+facing)
	elif velocity.is_zero_approx():
		_animation_player.play("idle_" + facing)
		pass
	elif !velocity.is_zero_approx():
		_animation_player.play("walk_" + facing)
		pass

func on_body_entered(body):
	if body.is_in_group("enemy"):
		change_health(-2)

func change_health(_amount:int):
		health += _amount
		if health < 1:
			die()
		if health > maxHealth:
			health = maxHealth
		print("Health: ", health)

func change_coins(_amount:int):
	coins += _amount
	print("you have " +str(coins) +" coins")

func die():
	print("you died")
	queue_free()

func shoot():
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position + offset
	projectile_clone.set_direction(facing)
	get_tree().get_root().add_child(projectile_clone)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		current_enemy = body
		print(current_enemy.name)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		current_enemy = null

func lever_slowed_effect(_amount:int):
	xSpeed += _amount
	ySpeed += _amount
