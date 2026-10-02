extends AudioStreamPlayer

var time_stamp = 0.0

func _enter_tree() -> void:
	play(time_stamp)

func _process(_delta: float) -> void:
	time_stamp = get_playback_position()
	
