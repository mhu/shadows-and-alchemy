extends RayCast2D

@onready var player: CharacterBody2D = owner.get_tree().current_scene.get_node("Player")
@onready var light_pivot: Marker2D = get_node("../LightPivot")


func _ready() -> void:
    pass


func _process(_delta: float) -> void:
    look_at(player.position)

    if is_colliding() and get_collider() == player:
        light_pivot.look_at(player.global_position)
