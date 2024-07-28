extends Node

var music := AudioStreamPlayer.new()
var sound := AudioStreamPlayer.new()
var is_muted: bool = false


func _ready() -> void:
    music.stream = load("res://assets/music/shadows-and-alchemy.mp3")
    music.autoplay = true
    music.volume_db = -5
    music.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(music)

    sound.stream = load("res://assets/music/shadows-and-alchemy-hit.mp3")
    sound.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(sound)


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("mute"):
        var index := AudioServer.get_bus_index("Master")

        if is_muted:
            is_muted = false
            AudioServer.set_bus_mute(index, false)
        else:
            is_muted = true
            AudioServer.set_bus_mute(index, true)


func play_enemy_hit() -> void:
    sound.play()
