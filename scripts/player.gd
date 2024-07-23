extends CharacterBody2D

enum Form {
    STAG,
    KANGAROO,
}

var health: int = 3
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var empty_heart_texture: Texture = preload("res://assets/sprites/heart_empty.png")
var current_form: Form = Form.STAG


func _ready() -> void:
    pass


func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y += gravity * delta

    if Input.is_action_just_pressed("transform"):
        change_form()

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = get_jump_velocity(current_form)

    var direction := Input.get_axis("move_left", "move_right")
    if direction:
        play_animation("run")
        velocity.x = direction * get_speed(current_form)
    else:
        play_animation("idle")
        velocity.x = move_toward(velocity.x, 0, get_speed(current_form))

    if direction > 0.0:
        $AnimatedSprite2D.flip_h = false
    elif direction < 0.0:
        $AnimatedSprite2D.flip_h = true

    move_and_slide()


func play_animation(_type: String) -> void:
    match current_form:
        Form.STAG:
            $AnimatedSprite2D.play("stag_idle")
        Form.KANGAROO:
            $AnimatedSprite2D.play("kangaroo_idle")
        _:
            $AnimatedSprite2D.play("stag_idle")

func get_speed(form: Form) -> float:
    match form:
        Form.STAG:
            return 200.0
        _:
            return 100.0


func get_jump_velocity(form: Form) -> float:
    match form:
        Form.KANGAROO:
            return -450.0
        _:
            return -350.0


func take_damage() -> void:
    health = max(0, health - 1)
    $HealthBar.get_child(health).set_texture(empty_heart_texture)

    if health == 0:
        TimerSingleton.stop_timer()

        get_tree().set_pause(true)
        $Camera2D/GameOverScreen.set_visible(true)
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func change_form() -> void:
    match current_form:
        Form.STAG:
            current_form = Form.KANGAROO
        Form.KANGAROO:
            current_form = Form.STAG
        _:
            current_form = Form.STAG
