extends Control

@onready var start_button: Button = $CenterContainer/MenuContent/StartButton
@onready var back_button: Button = $CenterContainer/MenuContent/BackButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	back_button.pressed.connect(_on_back_pressed)
	start_button.grab_focus()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level/outside.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
