extends Node2D

@export var drainage_scene: PackedScene
@export var trash_bin_scene: PackedScene

var money := 100
const DRAINAGE_COST := 30
const TRASH_BIN_COST := 20

@export var score := 0

var build_mode := ""

var current_week := 1
const MAX_WEEKS := 12

const MAX_ACTION_POINTS := 5
var action_points := MAX_ACTION_POINTS
var pollution := 0.0
const MAX_POLLUTION := 100.0

func _ready() -> void:
	add_to_group("game")
	get_tree().call_group("hud", "update_stats", money, score)
	get_tree().call_group("hud", "update_week", current_week, MAX_WEEKS)
	get_tree().call_group("hud", "update_ap", action_points, MAX_ACTION_POINTS)

func collect_house_waste(house):
	if !use_action_point():
		return
	var collected = house.collect_waste()
	money += collected
	score += collected
	pollution -= collected * 0.05
	pollution = clamp(pollution, 0.0, 100.0)
	get_tree().call_group("hud", "update_stats", money, score)

func simulate_week():
	for house in get_tree().get_nodes_in_group("houses"):
		house.generate_waste()
	print("Week simulated.")

func update_pollution():
	var total_waste := 0.0

	for house in get_tree().get_nodes_in_group("houses"):
		total_waste += house.waste

	pollution += total_waste * 0.1
	pollution = clamp(pollution, 0.0, 100.0)

func end_week():
	if current_week >= MAX_WEEKS:
		get_tree().quit()
		return

	simulate_week()
	update_pollution()

	action_points = MAX_ACTION_POINTS

	get_tree().call_group(
		"hud",
		"update_ap",
		action_points,
		MAX_ACTION_POINTS
	)
	current_week += 1

	get_tree().call_group(
		"hud",
		"update_week",
		current_week,
		MAX_WEEKS
	)

	get_tree().call_group(
		"hud",
		"update_pollution",
		pollution,
		MAX_POLLUTION
	)
func use_action_point() -> bool:
	if action_points <= 0:
		print("No Action Points left.")
		return false

	action_points -= 1

	get_tree().call_group(
		"hud",
		"update_ap",
		action_points,
		MAX_ACTION_POINTS
	)

	return true

func _input(event: InputEvent) -> void:
	# Enter Drainage Build Mode
	if event.is_action_pressed("build_drainage"):
		build_mode = "drainage"
		print("Drainage Build Mode ON")
	# Enter Trash Bin Build Mode
	if event.is_action_pressed("build_trash_bin"):
		build_mode = "trash_bin"
		print("Trash Bin Build Mode ON")
	# Handle building
	if build_mode != "" and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if build_mode == "drainage":
				place_drainage()
			elif build_mode == "trash_bin":
				place_trash_bin()
			build_mode = ""

func place_drainage():

	# Check money FIRST
	if money < DRAINAGE_COST:
		print("Not enough money!")
		return

	# Then check AP
	if !use_action_point():
		return

	money -= DRAINAGE_COST

	get_tree().call_group(
		"hud",
		"update_stats",
		money,
		score
	)

	var drainage = drainage_scene.instantiate()

	drainage.global_position = get_global_mouse_position()

	add_child(drainage)

	print("Drainage placed. Money:", money)

func place_trash_bin():
	# Check money FIRST
	if money < TRASH_BIN_COST:
		print("Not enough money!")
		return
	
	if !use_action_point():
		return
	money -= TRASH_BIN_COST
	get_tree().call_group(
		"hud",
		"update_stats",
		money,
		score
	)
	var trash_bin = trash_bin_scene.instantiate()
	trash_bin.global_position = get_global_mouse_position()
	add_child(trash_bin)
	print("Trash Bin placed. Money:", money)

func _on_button_2_pressed() -> void:
	get_tree().call_group("game", "end_week")
