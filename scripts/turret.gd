extends CharacterBody2D

var projectile_original = preload("res://scenes/enemy_projectile.tscn")

func _ready():
	
	pass

func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		
		# TODO: Create a new projectile instance
		var projectile_clone = projectile_original.instantiate()
	
	# TODO: Set projectile position to player position
		projectile_clone.global_position = position
	
	# TODO: Set projectile direction using facing variable
		projectile_clone.set_direction(body.position)
	
	# TODO: Add projectile to the game world
		get_tree().get_root().add_child(projectile_clone)

	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	
	
	pass
