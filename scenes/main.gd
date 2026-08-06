extends Node2D
@export var drainage_scene : PackedScene
var build_mode := false
func _on_timer_timeout() -> void:
	for house in get_tree().get_nodes_in_group("houses"):
		house.generate_waste()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("build_drainage"):
		build_mode = true

	if build_mode and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var drainage = drainage_scene.instantiate()
			drainage.global_position = get_global_mouse_position()
			add_child(drainage)
			build_mode = false
