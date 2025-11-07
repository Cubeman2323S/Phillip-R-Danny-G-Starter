extends Area2D
var speed = 200
var direction
var target
var timerstart = 8
var timer = timerstart

func set_direction(target):
	direction = position.direction_to(target)
	pass
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func _physics_process(delta: float):
	position += direction * speed*delta
func _on_body_entered(body):
	if body.name == "Player":
		body.change_health(-2)
		queue_free()
	pass
func _process(delta: float):
	if direction.x < 0:
		scale.x = -.5
	timer -= delta
	if timer < 0:
		queue_free()
