extends Node

@export var elapsed_time: float = 0.0


func _ready() -> void:
    TimerSingleton.start_timer()

    get_tree().set_pause(false)
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

    randomize_exit_location()


func randomize_exit_location() -> void:
    if not has_node("ExitLocations"):
        return

    var exit_node: AnimatedSprite2D = $Exit
    var exit_location_node: Node2D = $ExitLocations.get_children().pick_random()
    exit_node.global_position = exit_location_node.global_position


func _process(delta: float) -> void:
    elapsed_time += delta

    if Input.is_action_just_pressed("quit"):
        get_tree().quit()

    if Input.is_action_just_pressed("toggle_debug"):
        pass
