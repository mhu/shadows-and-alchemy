extends Node

var music := AudioStreamPlayer.new()
var sound := AudioStreamPlayer.new()


func _ready() -> void:
    music.stream = load("res://assets/music/shadows-and-alchemy.mp3")
    music.autoplay = true
    music.volume_db = -5
    add_child(music)

    sound.stream = load("res://assets/music/shadows-and-alchemy-hit.mp3")
    add_child(sound)


func play_enemy_hit() -> void:
    sound.play()
