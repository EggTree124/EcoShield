extends Area2D

@export var house_name := "House"
@export var waste := 20
@export var residents := 4
@export var waste_generation := 1
@export var max_waste := 100
var flooded := false
var in_flood_zone := false
func _ready():
	input_pickable = true
	add_to_group("houses")

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			get_tree().call_group("hud", "show_house_info", self)

func generate_waste():
	waste += waste_generation
	waste = min(waste, max_waste)
