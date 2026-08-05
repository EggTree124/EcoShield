extends Area2D
@export var water_level := 0
@export var max_water := 100
@export var flood_speed := 5

func _on_timer_timeout() -> void:
	water_level += flood_speed
	water_level = clamp(water_level, 0, max_water)
	print("Water Level:", water_level)
	
	for area in get_overlapping_areas():
		if area.is_in_group("houses"):
			area.current_water_level = water_level
func _on_area_entered(area) -> void:
	if area.is_in_group("houses"):
		print(area.house_name, " entered flood zone")
		area.in_flood_zone = true
		area.current_water_level = water_level

func _on_area_exited(area) -> void:
	if area.is_in_group("houses"):
		print(area.house_name, " left flood zone")
		area.in_flood_zone = false
		area.current_water_level = 0
