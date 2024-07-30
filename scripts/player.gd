extends CharacterBody2D

enum Form {
    STAG,
    KANGAROO,
}

@onready var health_bar: Node = $HealthBar
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var regeneration_particles: CPUParticles2D = $RegenerationParticles
const STARTING_POSITION: Vector2 = Vector2(23.0, -23.0)
const MAX_HEALTH: int = 3
var enemies: Node
var health: int = MAX_HEALTH
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var full_heart_texture: Texture = preload("res://assets/sprites/heart_full.png")
var empty_heart_texture: Texture = preload("res://assets/sprites/heart_empty.png")
var current_form: Form = Form.STAG
var regeneration_time: float = 0.0
var time_until_regenerate: float = 3.0


func _ready() -> void:
    if get_tree().current_scene.has_node("Enemies"):
        enemies = get_tree().current_scene.get_node("Enemies")


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


func _process(delta: float) -> void:
    if health >= MAX_HEALTH:
        return

    var closest_enemy: CharacterBody2D = get_closest_enemy()
    if closest_enemy == null:
        return

    ray_cast.look_at(closest_enemy.global_position)
    if ray_cast.is_colliding() && ray_cast.get_collider() == CharacterBody2D: # FIXME
        regeneration_time = 0.0
        regeneration_particles.visible = false
        return

    regeneration_time += delta
    regeneration_particles.visible = true

    if regeneration_time >= time_until_regenerate:
        update_health(1)
        regeneration_time = 0.0

        if health == MAX_HEALTH:
            regeneration_particles.visible = false


func get_closest_enemy() -> CharacterBody2D:
    if enemies == null:
        return null

    var closest_enemy: Node = null
    var closest_distance: float = INF

    for enemy in enemies.get_children():
        if global_position.distance_to(enemy.global_position) < closest_distance:
            closest_enemy = enemy
            closest_distance = global_position.distance_to(enemy.global_position)

    return closest_enemy


func play_animation(type: String) -> void:
    match current_form:
        Form.STAG:
            $AnimatedSprite2D.play("stag_" + type)
        Form.KANGAROO:
            $AnimatedSprite2D.play("kangaroo_" + type)
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
            return -550.0
        _:
            return -380.0


func take_damage() -> void:
    update_health(-1)

    if health == 0:
        TimerSingleton.stop_timer()

        get_tree().set_pause(true)
        $Camera2D/GameOverScreen.set_visible(true)
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func update_health(amount: int) -> void:
    health = max(0, health + amount)

    for n in range(MAX_HEALTH):
        if n < health:
            health_bar.get_child(n).set_texture(full_heart_texture)
        else:
            health_bar.get_child(n).set_texture(empty_heart_texture)


func change_form() -> void:
    match current_form:
        Form.STAG:
            current_form = Form.KANGAROO
        Form.KANGAROO:
            current_form = Form.STAG
        _:
            current_form = Form.STAG
