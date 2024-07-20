extends AnimatedSprite2D

func _ready() -> void:
    pass


func _process(_delta: float) -> void:
    pass


func _on_area_2d_body_entered(_body: Node2D) -> void:
    get_tree().set_pause(true)
    $"../Player/Camera2D/GameOverScreen".set_visible(true)
