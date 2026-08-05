extends Area2D
@export var water_level := 0
@export var max_water := 100
@export var flood_speed := 5

func _on_timer_timeout() -> void:
	water_level += flood_speed
	water_level = clamp(water_level, 0, max_water)

func _on_body_entered(body) -> void:
	if body.is_in_group("houses"):
		body.in_flood_zone = true

func _on_body_exited(body) -> void:
	if body.is_in_group("houses"):
		body.in_flood_zone = false
