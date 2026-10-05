extends Control

signal back_requested

@onready var master_volume_slider: HSlider = $CenterContainer/MenuContent/MasterVolumeSlider
@onready var volume_value: Label = $CenterContainer/MenuContent/VolumeValue
@onready var fullscreen_toggle: CheckButton = $CenterContainer/MenuContent/FullscreenToggle
@onready var back_button: Button = $CenterContainer/MenuContent/BackButton

var master_bus_index: int


func _ready() -> void:
	master_bus_index = AudioServer.get_bus_index("Master")
	if master_bus_index == -1:
		push_error("Settings menu could not find the Master audio bus.")
		master_volume_slider.editable = false
	else:
		master_volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_index))
		master_volume_slider.value_changed.connect(_on_master_volume_changed)
		_on_master_volume_changed(master_volume_slider.value)

	fullscreen_toggle.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	fullscreen_toggle.toggled.connect(_on_fullscreen_toggled)
	back_button.pressed.connect(_on_back_pressed)
	back_button.grab_focus()


func _on_master_volume_changed(value: float) -> void:
	volume_value.text = "%d%%" % roundi(value * 100.0)
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(maxf(value, 0.0001)))


func _on_fullscreen_toggled(enabled: bool) -> void:
	var mode := DisplayServer.WINDOW_MODE_FULLSCREEN if enabled else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(mode)


func _on_back_pressed() -> void:
	if get_tree().current_scene == self:
		get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
	else:
		back_requested.emit()
