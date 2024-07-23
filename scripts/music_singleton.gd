extends Node

var music := AudioStreamPlayer.new()


func _ready() -> void:
    music.stream = load("res://assets/music/shadows-and-alchemy.mp3")
    music.autoplay = true
    music.volume_db = -5
    add_child(music)
