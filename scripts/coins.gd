extends Node


func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		body.change_coins(1)
		queue_free()
	
	
	# TODO: Print a message when the coin is collected
	
	
	
	# TODO: Remove the coin from the game
