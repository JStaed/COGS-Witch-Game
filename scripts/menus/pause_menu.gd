extends CanvasLayer

@onready var resume_button: Button = $CenterContainer/MenuPanel/MenuButtons/ResumeButton
@onready var main_menu_button: Button = $CenterContainer/MenuPanel/MenuButtons/MainMenuButton
@onready var options_button: Button = $CenterContainer/MenuPanel/MenuButtons/OptionsButton
@onready var menu_panel: PanelContainer = $CenterContainer/MenuPanel
@onready var settings_menu: Control = $CenterContainer/SettingsMenu


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	resume_button.pressed.connect(_on_resume_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	options_button.pressed.connect(_on_options_pressed)
	settings_menu.back_requested.connect(_on_settings_back_requested)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and not event.is_echo():
		if visible:
			_resume_game()
		else:
			_pause_game()
		get_viewport().set_input_as_handled()


func _pause_game() -> void:
	visible = true
	get_tree().paused = true
	resume_button.grab_focus()


func _resume_game() -> void:
	get_tree().paused = false
	visible = false


func _on_resume_pressed() -> void:
	_resume_game()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _on_options_pressed() -> void:
	menu_panel.hide()
	settings_menu.show()
	settings_menu.get_node("CenterContainer/MenuContent/BackButton").grab_focus()


func _on_settings_back_requested() -> void:
	settings_menu.hide()
	menu_panel.show()
	options_button.grab_focus()
