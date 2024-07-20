extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -350.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y += gravity * delta

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    var direction := Input.get_axis("move_left", "move_right")
    if direction:
        $AnimatedSprite2D.play("walk")
        velocity.x = direction * SPEED
    else:
        $AnimatedSprite2D.stop()
        velocity.x = move_toward(velocity.x, 0, SPEED)

    if direction > 0.0:
        $AnimatedSprite2D.flip_h = false
    elif direction < 0.0:
        $AnimatedSprite2D.flip_h = true

    move_and_slide()
