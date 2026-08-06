extends Node2D

@export var drainage_scene: PackedScene

var money := 100
const DRAINAGE_COST := 30

var build_mode := false

func _ready() -> void:
	get_tree().call_group("hud", "update_money", money)

func _on_timer_timeout() -> void:
	for house in get_tree().get_nodes_in_group("houses"):
		house.generate_waste()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("build_drainage"):
		build_mode = true
		print("Build Mode ON")

	if build_mode and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if money < DRAINAGE_COST:
				print("Not enough money!")
				build_mode = false
				return
			money -= DRAINAGE_COST
			get_tree().call_group("hud", "update_money", money)
			var drainage = drainage_scene.instantiate()
			drainage.global_position = get_global_mouse_position()
			add_child(drainage)
			print("Drainage placed. Money:", money)
			build_mode = false
