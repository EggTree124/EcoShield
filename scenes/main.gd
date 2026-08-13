extends Node2D

@export var drainage_scene: PackedScene
@export var trash_bin_scene: PackedScene
@export var tree_scene: PackedScene
var money := 100
const DRAINAGE_COST := 30
const TRASH_BIN_COST := 20
const TREE_COST := 25

@export var score := 0

var build_mode := ""

var current_week := 1
const MAX_WEEKS := 12

const MAX_ACTION_POINTS := 5
var action_points := MAX_ACTION_POINTS
var pollution := 0.0
const MAX_POLLUTION := 100.0
var current_event := "None"
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
	
func generate_random_event():
	var events = [
		"Heavy Rain",
		"Illegal Dumping"
	]
	current_event = events.pick_random()
	print("Event: ", current_event)

func apply_event():
	match current_event:
		"Heavy Rain":
			heavy_rain()
		"Illegal Dumping":
			illegal_dumping()

func heavy_rain():
	print("Heavy rain!")

	for flood_zone in get_tree().get_nodes_in_group("flood_zones"):
		flood_zone.water_level += 25

	get_tree().call_group(
		"hud",
		"update_event",
		"HEAVY RAIN",
		"Flood water increased."
	)

func illegal_dumping():
	var houses = get_tree().get_nodes_in_group("houses")

	if houses.is_empty():
		return

	var house = houses.pick_random()
	house.waste += 20

	print("Illegal dumping at ", house.name)

	get_tree().call_group(
		"hud",
		"update_event",
		"ILLEGAL DUMPING",
		house.name + " gained 20 kg waste."
	)

func update_flooding():
	for flood_zone in get_tree().get_nodes_in_group("flood_zones"):
		var reduction := 0.0

		for tree in get_tree().get_nodes_in_group("trees"):
			if tree.global_position.distance_to(flood_zone.global_position) <= tree.effect_radius:
				reduction += tree.flood_reduction

		flood_zone.water_level -= reduction
		flood_zone.water_level = max(flood_zone.water_level, 0.0)

func end_week():
	if current_week >= MAX_WEEKS:
		if current_week >= MAX_WEEKS:
			var final_score := calculate_final_score()
			var rating := get_final_rating(final_score)
			print("===== GAME OVER =====")
			print("Final Score: ", final_score)
			print("Rating: ", rating)
			print("Money: ", money)
			print("Pollution: ", pollution)
			print("Flooded Houses: ", get_flooded_house_count())

		return
	
	clear_event()
	simulate_week()
	
	if randf() > 0.3:
		generate_random_event()
		apply_event()
	action_points = MAX_ACTION_POINTS
	update_pollution()
	update_flooding()
	
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
	
	update_flooding()
	print("Week simulated")

func clear_event():
	get_tree().call_group(
		"hud",
		"update_event",
		"NONE",
		"No special events this week."
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
	if event.is_action_pressed("build_drainage"):
		build_mode = "drainage"
		print("Drainage Build Mode ON")
	# Enter Trash Bin Build Mode
	if event.is_action_pressed("build_trash_bin"):
		build_mode = "trash_bin"
		print("Trash Bin Build Mode ON")
	if event.is_action_pressed("build_tree"):
		build_mode = "tree"
		print("Tree Build Mode ON")

	# Handle building
	if build_mode != "" and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if build_mode == "drainage":
				place_drainage()
			elif build_mode == "trash_bin":
				place_trash_bin()
			elif build_mode == "tree":
				place_tree()
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

func place_tree():
	if money < TREE_COST:
		print("Not enough money!")
		return

	if !use_action_point():
		return

	money -= TREE_COST

	var tree = tree_scene.instantiate()
	tree.global_position = get_global_mouse_position()
	add_child(tree)

	get_tree().call_group(
		"hud",
		"update_stats",
		money,
		score
	)

	print("Tree planted. Money:", money)
func _on_button_2_pressed() -> void:
	get_tree().call_group("game", "end_week")


func calculate_final_score() -> int:
	var final_score := score
	final_score -= int(pollution)
	var flooded_houses := get_flooded_house_count()
	final_score -= flooded_houses * 25
	final_score += money

	return max(final_score, 0)
	
func get_flooded_house_count() -> int:
	var flooded := 0

	for house in get_tree().get_nodes_in_group("houses"):
		if house.flooded:
			flooded += 1

	return flooded
	
func get_final_rating(final_score: int) -> String:
	if final_score >= 800:
		return "S"
	elif final_score >= 600:
		return "A"
	elif final_score >= 400:
		return "B"
	elif final_score >= 200:
		return "C"
	else:
		return "D"
