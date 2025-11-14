extends CharacterBody2D
@onready var player: CharacterBody2D = %Player
var ranged = false
var chase = false
var melee = false
var speed = 200
var target
var facing = "up"
var maxtimer2 = .75
var timer2 = maxtimer2
var XDirection = 0
var YDirection = 0
var direction
var is_attacking = false
var attack_timer = .6
var current_enemy
@onready var _animation_melee_minotaur: AnimatedSprite2D = $AnimatedSprite2D
var projectile_original = preload("res://scenes/enemy_arrow.tscn")
@onready var melee_box : CollisionShape2D = $Area2D/CollisionShape2D

#func set_direction(target):
	#direction = position.direction_to(target)
func _process(delta: float) -> void:
	timer2 -= delta
	XDirection = player.position.x - position.x
	YDirection = player.position.y - position.y
	if abs(XDirection) > abs(YDirection):
		if XDirection > 0:
			facing = "right"
			melee_box.position = Vector2(30,10)
		elif XDirection < 0:
			facing = "left"
			melee_box.position = Vector2(-30,10)
	else:
		if YDirection < 0:
			facing = "up"
			melee_box.position = Vector2(0,-20)
		elif YDirection > 0:
			facing = "down"
			melee_box.position = Vector2(0,40)
	if ranged:
		if timer2 < 0:
			shoot()
			timer2 = maxtimer2
			_animation_melee_minotaur.play("crossbow_shoot_" + facing)
	elif chase:
		_animation_melee_minotaur.play("walk_" + facing)
		position += position.direction_to(player.position) * speed * delta
		
		pass
	elif melee:
		if is_attacking:
			attack_timer -= delta
			_animation_melee_minotaur.play("attack_" + facing)
		if attack_timer < 0:
			print("attack_end")
			is_attacking = false
			attack_timer = .66
		if is_attacking and current_enemy != null:
			print("should die")
			player.change_health(-2)
			pass
		else:
			_animation_melee_minotaur.play("crossbow_idle_" + facing)
	#set_direction(target)

func _ready() -> void:
	pass

func shoot():
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position
	projectile_clone.set_direction(player.position)
	get_tree().get_root().add_child(projectile_clone)


func _on_ranged_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		ranged = true
		target = body.position

func _on_ranged_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		ranged = false

func _on_chase_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		ranged = false
		chase = true

func _on_chase_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		ranged = true
		chase = false

func _on_melee_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		chase = false
		melee = true

func _on_melee_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		chase = true
		melee = false

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		current_enemy = body
		print(current_enemy.name)

func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		current_enemy = null
