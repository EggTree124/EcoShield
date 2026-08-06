extends Area2D

@export var drain_speed := 10

func _on_timer_timeout():
	print("Drainage good")
	for zone in get_overlapping_areas():
		if zone.is_in_group("flood_zones"):
			zone.water_level -= drain_speed
			zone.water_level = max(zone.water_level, 0)
