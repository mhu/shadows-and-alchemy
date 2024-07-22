extends CanvasLayer


func _ready() -> void:
    $MarginContainer/VBoxContainer/TimerLabel.text = "Time: " + format_time(TimerSingleton.get_elapsed_time())


func _process(_delta: float) -> void:
    pass


func format_time(elapsed_time: float) -> String:
    var seconds: int = int(elapsed_time)
    var minutes: int = seconds / 60
    var secs: int = seconds % 60
    var milliseconds: int = int((elapsed_time - seconds) * 1000)

    return str(minutes).pad_zeros(2) + ":" + str(secs).pad_zeros(2) + ":" + str(milliseconds).pad_zeros(3)


func _on_retry_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/tutorial.tscn")


func _on_quit_button_pressed() -> void:
    get_tree().quit()
