extends CanvasLayer

@onready var panel = $Panel
@onready var house_name = $Panel/VBoxContainer/Label
@onready var residents = $Panel/VBoxContainer/Label2
@onready var waste = $Panel/VBoxContainer/Label3
var current_house: Area2D = null
func _ready():
	panel.hide()

func show_house_info(house):
	current_house = house
	panel.show()
	house_name.text = house.house_name
	residents.text = "Residents: %d" % house.residents
	waste.text = "Waste: %d kg" % house.waste

func _on_button_pressed() -> void:
	if current_house == null:
		return
	current_house.waste = 0
	waste.text = "Waste: 0 kg"
