extends Area2D
@export var water_level := 0
@export var max_water := 100
@export var flood_speed := 5
func _ready() -> void:
	add_to_group("floodzones")
func _on_timer_timeout() -> void:
	water_level += flood_speed
	water_level = clamp(water_level, 0, max_water)
	
	for area in get_overlapping_areas():
		if area.is_in_group("houses"):
			area.current_water_level = water_level
func _on_area_entered(area) -> void:
	if area.is_in_group("houses"):
		area.in_flood_zone = true
		area.current_water_level = water_level

func _on_area_exited(area) -> void:
	if area.is_in_group("houses"):
		area.in_flood_zone = false
		area.current_water_level = 0
