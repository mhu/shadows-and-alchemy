extends Node

@export var elapsed_time: float = 0.0


func _ready() -> void:
    TimerSingleton.start_timer()

    get_tree().set_pause(false)
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta: float) -> void:
    elapsed_time += delta

    if Input.is_action_just_pressed("quit"):
        get_tree().quit()

    if Input.is_action_just_pressed("toggle_debug"):
        pass
