extends Node


func _on_body_entered(body):
	if body.is_in_group("player"):
		GameManager.add_coin()
		queue_free()
	
