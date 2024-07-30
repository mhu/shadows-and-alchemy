extends RayCast2D

@onready var player: CharacterBody2D = owner.get_tree().current_scene.get_node("Player")
@onready var light_pivot: Marker2D = get_node("../LightPivot")


func _ready() -> void:
    pass


func _process(_delta: float) -> void:
    # This is to avoid the detector ray colliding with the character's model
    # on the first few frames before the tilemap is loaded (?)
    if player.global_position == player.STARTING_POSITION:
        return

    look_at(player.global_position)

    if is_colliding() and get_collider() == player:
        light_pivot.look_at(player.global_position)
