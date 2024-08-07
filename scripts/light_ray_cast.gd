extends RayCast2D

@onready var player: CharacterBody2D = owner.get_tree().current_scene.get_node("Player")
@onready var point_light: PointLight2D = get_node("../PointLight2D") # TODO: improve path
var collide_duration: float = 0.0
var time_until_damage: float = 1.5


func _ready() -> void:
    pass


func _process(delta: float) -> void:
    if is_colliding() and get_collider() == player:
        collide_duration += delta

        if collide_duration >= time_until_damage:
            point_light.hit(player)
            collide_duration = 0
    else:
        collide_duration = 0
