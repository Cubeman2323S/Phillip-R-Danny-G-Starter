extends CharacterBody2D
var timerstart = 2
var timer = timerstart
var radius = false
var player

var projectile_original = preload("res://scenes/enemy_projectile.tscn")

func _ready():
	
	pass

func _process(delta: float) -> void:
	if radius == true:
		timer -= delta
		if timer < 0:
			shoot(player)
			timer = timerstart
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	if body.name == "Player":
		radius = true

	pass
func shoot(body):
	if body.name == "Player":
		var projectile_clone = projectile_original.instantiate()
		projectile_clone.global_position = position
		projectile_clone.set_direction(body.position)
		get_tree().get_root().add_child(projectile_clone)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		radius = false
	
	pass
