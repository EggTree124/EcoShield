extends Node2D

func _on_timer_timeout() -> void:
	for house in get_tree().get_nodes_in_group("houses"):
		house.generate_waste()
