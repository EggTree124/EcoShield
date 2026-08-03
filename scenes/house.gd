extends Area2D

@export var house_name := "House"
@export var waste := 20
@export var residents := 4

func _ready():
	input_pickable = true

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			get_tree().call_group("hud", "show_house_info", self)
