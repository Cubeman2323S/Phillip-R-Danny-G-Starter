extends CharacterBody2D
var max_health = 10
var health = max_health
func change_health(_amount:int):
		health += _amount
		if health < 1:
			queue_free()
		if health > max_health:
			health = max_health
		print("Health: ", health)
