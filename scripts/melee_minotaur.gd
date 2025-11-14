extends CharacterBody2D
@onready var player: CharacterBody2D = %Player
var ranged = false
var chase = false
var melee = false
var speed = 200
var target
var facing = "right"
var maxtimer2 = .75
var timer2 = maxtimer2
var direction
@onready var _animation_melee_minotaur: AnimatedSprite2D = $AnimatedSprite2D
var projectile_original = preload("res://scenes/enemy_arrow.tscn")

#func set_direction(target):
	#direction = position.direction_to(target)
func _process(delta: float) -> void:
	timer2 -= delta
	if ranged:
		if timer2 < 0:
			shoot()
			timer2 = maxtimer2
			_animation_melee_minotaur.play("crossbow_shoot_" + facing)
	elif chase:
		_animation_melee_minotaur.play("walk_" + facing)
		position += direction * speed * delta
		pass
	elif melee:
		if timer2 < 0:
			timer2 = maxtimer2
			_animation_melee_minotaur.play("attack_" + facing)
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
