extends Control

@onready var back_button: Button = $CenterContainer/MenuContent/BackButton


func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	back_button.grab_focus()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
