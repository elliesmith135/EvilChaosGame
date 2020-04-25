extends RigidBody2D

var velocity = Vector2(0,0)
export var speed = 50

func _ready():
	velocity.y = speed
	contact_monitor = true
	set_max_contacts_reported(4)
	linear_velocity = velocity

func _physics_process(delta):
	var colliding = get_colliding_bodies()
	for c in colliding:
		if c.name == "Player":
			c.change_acceleration(0.1)
		queue_free()
		
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()

func _integrate_forces(state):
	#state.set_linear_velocity(velocity)
	pass