extends Node2D

@export var drainage_scene: PackedScene

var money := 100
const DRAINAGE_COST := 30
@export var score := 0

var build_mode := false

var current_week := 1
const MAX_WEEKS := 12

const MAX_ACTION_POINTS := 5
var action_points := MAX_ACTION_POINTS

func _ready() -> void:
	add_to_group("game")
	get_tree().call_group("hud", "update_stats", money, score)
	get_tree().call_group("hud", "update_week", current_week, MAX_WEEKS)
	get_tree().call_group("hud","update_ap",action_points,MAX_ACTION_POINTS
)
func collect_house_waste(house):
	if !use_action_point():
		return
	var collected = house.collect_waste()
	money += collected
	score += collected
	get_tree().call_group("hud", "update_stats", money, score)

func simulate_week():
	for house in get_tree().get_nodes_in_group("houses"):
		house.generate_waste()
	print("Week simulated.")

func end_week():
	if current_week >= MAX_WEEKS:
		get_tree().quit()
		return
	simulate_week()
	action_points = MAX_ACTION_POINTS
	get_tree().call_group("hud","update_ap",action_points,MAX_ACTION_POINTS)
	current_week += 1
	get_tree().call_group("hud","update_week",current_week,MAX_WEEKS)

func use_action_point() -> bool:
	if action_points <= 0:
		print("No Action Points left.")
		return false
	action_points -= 1
	get_tree().call_group("hud","update_ap",action_points,MAX_ACTION_POINTS)
	return true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("build_drainage"):
		build_mode = true
		print("Build Mode ON")

	if build_mode and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if !use_action_point():
				build_mode = false
				return
			if money < DRAINAGE_COST:
				build_mode = false
				return
			money -= DRAINAGE_COST
			get_tree().call_group("hud", "update_stats", money, score)
			var drainage = drainage_scene.instantiate()
			drainage.global_position = get_global_mouse_position()
			add_child(drainage)
			print("Drainage placed. Money:", money)
			build_mode = false

func _on_button_2_pressed() -> void:
	get_tree().call_group("game", "end_week")
