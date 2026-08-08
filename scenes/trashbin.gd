extends Area2D

@export var waste_reduction := 0.5

func affects_house(house) -> bool:
	return global_position.distance_to(house.global_position) <= 150
