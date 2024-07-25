extends Node

var music := AudioStreamPlayer.new()
var sound := AudioStreamPlayer.new()


func _ready() -> void:
    music.stream = load("res://assets/music/shadows-and-alchemy.mp3")
    music.autoplay = true
    music.volume_db = -5
    music.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(music)

    sound.stream = load("res://assets/music/shadows-and-alchemy-hit.mp3")
    sound.process_mode = Node.PROCESS_MODE_ALWAYS
    add_child(sound)


func play_enemy_hit() -> void:
    sound.play()
