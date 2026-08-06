extends CanvasLayer

@onready var panel = $Panel
@onready var house_name = $Panel/VBoxContainer/Label
@onready var residents = $Panel/VBoxContainer/Label2
@onready var waste = $Panel/VBoxContainer/Label3
@onready var status = $Panel/VBoxContainer/Label4
@onready var money_label: Label = $Panel/VBoxContainer/Label5
var current_house: Area2D = null
func _ready():
	panel.hide()

func show_house_info(house):
	current_house = house
	panel.show()
	house_name.text = house.house_name
	residents.text = "Residents: %d" % house.residents
	waste.text = "Waste: %d kg" % house.waste
	if house.flooded:
		status.text = "Status: 🌊 Flooded"
	else:
		status.text = "Status: Safe"

func update_money(money):
	money_label.text = "Money: " + str(money)
	
func _on_button_pressed() -> void:
	if current_house == null:
		return
	current_house.waste = 0
	waste.text = "Waste: 0 kg"

func _process(delta: float) -> void:
	if current_house:
		waste.text = "Waste: %d kg" % current_house.waste
		if current_house.waste >= 80:
			waste.add_theme_color_override("font_color", Color.RED)
		else:
			waste.add_theme_color_override("font_color", Color.WHITE)
		if current_house.flooded:
			status.text = "Status: 🌊 Flooded"
		else:
			status.text = "Status: Safe"
