extends CharacterBody2D

@export var walk_speed: int = 130
@export var run_speed: int = 260
@export var acceleration: float = 800.0
@export var deceleration: float = 1200.0
var current_speed: int

@onready var anim: AnimatedSprite2D = %AnimatedSprite2D
	
func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("Left","Right","Up","Down")
	var is_running: bool = Input.is_action_pressed("Run")
	current_speed = run_speed if is_running else walk_speed
	
	var target_velocity: Vector2 = direction * current_speed

	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	if not is_zero_approx(velocity.x):
		anim.flip_h = (velocity.x < 0)
	
	update_animation()
	move_and_slide()

func update_animation():
	if velocity == Vector2(0,0):
		anim.play("idle")
	
	else:
		if current_speed == run_speed:
			anim.play("run_right")
		else:
			anim.play("walk_right")
