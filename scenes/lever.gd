extends Area2D
@onready var _animation_lever: AnimatedSprite2D = $AnimatedSprite2D
var lever_on = false
var player
var in_range = false
@onready var range: Area2D = $Area2D

func on_body_entered(body):
	if body == "Player":
		print("in_Range!")
		in_range = true
func on_body_exited(body):
	if body == "Player":
		in_range = false
		print("out of range):")

func _process(_float) -> void:
	if in_range == true and Input.is_action_just_pressed("ui_accept"):
		if lever_on == true:
			lever_on = false
		else:
			lever_on = true
		update_animation()
func update_animation():
	if lever_on == false:
		_animation_lever.play("off")
	else:
		_animation_lever.play("on")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("in_Range!")
		in_range = true
		pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false
		print("out of range):")
	pass # Replace with function body.
