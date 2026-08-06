extends Area2D

@export var drain_speed := 2

func _on_timer_timeout():
	for zone in get_overlapping_areas():
		if zone.is_in_group("flood_zones"):
			zone.water_level -= drain_speed
			zone.water_level = max(zone.water_level, 0)
