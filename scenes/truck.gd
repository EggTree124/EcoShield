extends Area2D

@export var collection_interval: float = 5.0

func _ready():
	$Timer.wait_time = collection_interval
	$Timer.start()

func _on_timer_timeout():
	collect_nearby_garbage()

func collect_nearby_garbage():
	for bin in get_overlapping_areas():
		if bin.is_in_group("trash_bins"):
			collect_garbage(bin)

func collect_garbage(bin):
	var collected = bin.waste
	bin.waste = 0
	print("Collected ", collected, " kg from ", bin.name)
