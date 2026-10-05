extends Control

@onready var play_button: Button = $CenterContainer/MenuButtons/PlayButton
@onready var options_button: Button = $CenterContainer/MenuButtons/OptionsButton
@onready var credits_button: Button = $CenterContainer/MenuButtons/CreditsButton
@onready var quit_button: Button = $CenterContainer/MenuButtons/QuitButton


func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_settings_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	play_button.grab_focus()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/save_select_menu.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/settings_menu.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/credits_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
