extends AnimatedSprite2D

@onready var player: CharacterBody2D = owner.get_tree().current_scene.get_node("Player")
@onready var game_over_screen: CanvasLayer = player.get_node("Camera2D/GameOverScreen")


func _ready() -> void:
    pass


func _process(_delta: float) -> void:
    pass


func _on_area_2d_body_entered(_body: Node2D) -> void:
    var current_scene_name: String = get_tree().current_scene.name

    match current_scene_name:
        "Tutorial":
            call_deferred("change_level")
        "Level1":
            show_game_over()


func change_level() -> void:
    get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func show_game_over() -> void:
    TimerSingleton.stop_timer()

    get_tree().set_pause(true)
    game_over_screen.set_visible(true)
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
