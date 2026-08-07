extends CanvasLayer

@onready var panel = $Panel
@onready var house_name = $Panel/VBoxContainer/Label
@onready var residents = $Panel/VBoxContainer/Label2
@onready var waste = $Panel/VBoxContainer/Label3
@onready var status = $Panel/VBoxContainer/Label4
@onready var money_label: Label = $Panel/VBoxContainer/Label5
@onready var score_label: Label = $Panel/VBoxContainer/Label6
@onready var week_label: Label = $Panel/VBoxContainer/Label7
@onready var ap_label: Label = $Panel/VBoxContainer/Label8

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

func update_stats(money, score):
	money_label.text = "Money: " + str(money)
	score_label.text = "Score: " + str(score)

func update_week(week, max_week):
	week_label.text = "Week: %d / %d" % [week, max_week]

func update_ap(ap, max_ap):
	ap_label.text = "AP: %d / %d" % [ap, max_ap]

func _on_button_pressed() -> void:
	if current_house == null:
		return
	get_tree().call_group("game", "collect_house_waste", current_house)

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
