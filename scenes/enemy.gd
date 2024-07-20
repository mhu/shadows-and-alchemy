extends CharacterBody2D

@onready var player: CharacterBody2D = $/root/Main/Player


func _ready() -> void:
    pass


func _process(_delta: float) -> void:
    $LightPivot.look_at(player.global_position)
    if player.global_position.x < global_position.x:
        $AnimatedSprite2D.flip_h = true
    else:
        $AnimatedSprite2D.flip_h = false
