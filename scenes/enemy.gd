extends CharacterBody2D

@onready var player: CharacterBody2D = $/root/Main/Player


func _ready() -> void:
    $LightPivot.look_at(player.global_position)


func _process(_delta: float) -> void:
    if global_position.distance_to(player.global_position) < 100.0:
        $LightPivot.look_at(player.global_position)

    if player.global_position.x < global_position.x:
        $AnimatedSprite2D.flip_h = true
    else:
        $AnimatedSprite2D.flip_h = false
