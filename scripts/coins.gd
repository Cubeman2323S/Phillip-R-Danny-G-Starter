extends Node


func _on_body_entered(body):
<<<<<<< Updated upstream
	if body.name == "CharacterBody2D":
=======
<<<<<<< HEAD
	if body.name == "Player":
		body.change_coins(1)
		queue_free()
=======
	if body.name == "CharacterBody2D":
>>>>>>> 4524b769df2c59c348d99515c4841a447eb50085
>>>>>>> Stashed changes
	# TODO: Check if the object that touched the coin is the player
		body.change_coins(1)
		queue_free()
	
	
	# TODO: Print a message when the coin is collected
	
	
	
	# TODO: Remove the coin from the game
