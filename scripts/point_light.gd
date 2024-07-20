extends PointLight2D

var color_timer: Timer


func _ready() -> void:
    color = Color(255.0, 255.0, 255.0)

    color_timer = Timer.new()
    color_timer.wait_time = 0.05
    color_timer.timeout.connect(_on_color_timer_timeout)
    add_child(color_timer)


func _process(_delta: float) -> void:
    pass


func hit(target: CharacterBody2D) -> void:
    if target.has_method("take_damage"):
        target.take_damage()

    color = Color(255.0, 0.0, 0.0)
    color_timer.start()


func _on_color_timer_timeout() -> void:
    color = Color(255.0, 255.0, 255.0)
