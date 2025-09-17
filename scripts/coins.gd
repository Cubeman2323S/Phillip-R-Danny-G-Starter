extends Node


func _on_body_entered(body):
	if body.name == "CharacterBody2D":
	# TODO: Check if the object that touched the coin is the player
		body.change_coins(1)
		queue_free()
	
	
	# TODO: Print a message when the coin is collected
	
	
	
	# TODO: Remove the coin from the game
	
	
