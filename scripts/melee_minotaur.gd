extends CharacterBody2D
@onready var player: CharacterBody2D = %Player
var ranged = false
var chase = false
var melee = false
var speed = 300
var facing = "right"

#Add arrow preload (NOT CLICKBAIT, FREE IPHONE 100 GIVEWAYWAY)

func _process(delta: float) -> void:
	if ranged:
		shoot()
		_animation_melee_minotaur.play("crossbow_shoot_" + facing)
	elif chase:
		_animation_melee_minotaur.play("walk_" + facing)
		pass
	elif melee:
		_animation_melee_minotaur.play("attack_" + facing)
		pass
	else:
		_animation_melee_minotaur.play("crossbow_idle_" + facing)

func _ready() -> void:
	pass

func shoot():
	pass


func _on_ranged_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		ranged = true
		pass


func _on_ranged_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		ranged = false
		pass


func _on_chase_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		ranged = false
		chase = true
		pass


func _on_chase_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		ranged = true
		chase = false
		pass


func _on_melee_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		chase = false
		melee = true
		pass


func _on_melee_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		chase = true
		melee = false
		pass
