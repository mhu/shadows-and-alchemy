extends Node


func _ready() -> void:
    get_tree().set_pause(false)
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("quit"):
        get_tree().quit()

    if Input.is_action_just_pressed("toggle_debug"):
        pass
