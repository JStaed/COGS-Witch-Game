extends AudioStreamPlayer

const CROSSFADE_DURATION = 1.0
var time_stamp = 0.0

var songs = [
	"res://audio/music/placeholder_music.wav",
	"res://audio/music/(Intro Backup)The_Mountain Spooky Stories.mp3"
	]

func _ready() -> void:
	get_tree().scene_changed.connect(_on_scene_changed)
	_on_scene_changed()

func _on_scene_changed() -> void:
	var scene := get_tree().current_scene
	var next_stream = load(songs[scene.get_meta("music_id")])
	if stream == next_stream:
		if not playing:
			play(time_stamp)
		return

	$Crossfade.stream = stream
	stream = next_stream
	volume_linear = 0
	play(0)
	$Crossfade.play(time_stamp)
	$Crossfade.volume_linear = 1
	var crossfade_tween = get_tree().create_tween()
	crossfade_tween.tween_property($Crossfade, "volume_linear", 0, CROSSFADE_DURATION)
	crossfade_tween.tween_property(self, "volume_linear", 1, CROSSFADE_DURATION)
	crossfade_tween.play()

func _process(_delta: float) -> void:
	time_stamp = get_playback_position()
	
