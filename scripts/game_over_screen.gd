extends CanvasLayer


func _ready() -> void:
    pass


func _process(_delta: float) -> void:
    pass


func _on_retry_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_button_pressed() -> void:
    get_tree().quit()
