extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -350.0

var health: int = 3
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var empty_heart_texture: Texture = preload("res://assets/sprites/heart_empty.png")


func _ready() -> void:
    get_tree().set_pause(false)


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


func take_damage() -> void:
    health = max(0, health - 1)
    $HealthBar.get_child(health).set_texture(empty_heart_texture)

    if health == 0:
        get_tree().set_pause(true)
        $Camera2D/GameOverScreen.set_visible(true)
