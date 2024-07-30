extends CharacterBody2D

@onready var player: CharacterBody2D = owner.get_tree().current_scene.get_node("Player")


func _ready() -> void:
    pass


func _process(_delta: float) -> void:
    if player.global_position.x < global_position.x:
        $AnimatedSprite2D.flip_h = true
        $LightPivot.position.x = -2.0
    else:
        $AnimatedSprite2D.flip_h = false
        $LightPivot.position.x = 2.0
